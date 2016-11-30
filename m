From: Baoquan He <bhe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH] iommu/vt-d: Flush old iotlb for kdump when the device
	gets context mapped
Date: Wed, 30 Nov 2016 17:53:34 +0800
Message-ID: <20161130095334.GB4192@x1>
References: <1479286950-21885-1-git-send-email-xlpang@redhat.com>
	<582C232F.6080205@redhat.com>
	<CAL-B5D1kkWE4e6P1xY1Cgkf-7+nBXH=C7g21=phEzmM4FPZRRQ@mail.gmail.com>
	<582D1A40.409@redhat.com> <20161129143547.GG2078@8bytes.org>
	<583E8A9B.7070906@redhat.com> <20161130090327.GA4192@x1>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20161130090327.GA4192@x1>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: xlpang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
Cc: Don Brace <don.brace-dzo6w/eZyo2tG0bUXCXiUA@public.gmane.org>, Dave Young <dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, LKML <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, Myron Stowe <myron.stowe-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 11/30/16 at 05:03pm, Baoquan He wrote:
> On 11/30/16 at 04:15pm, Xunlei Pang wrote:
> > On 11/29/2016 at 10:35 PM, Joerg Roedel wrote:
> > > On Thu, Nov 17, 2016 at 10:47:28AM +0800, Xunlei Pang wrote:
> > >> As per the comment, the code here only needs to flush context caches
> > >> for the special domain 0 which is used to tag the
> > >> non-present/erroneous caches, seems we should flush the old domain id
> > >> of present entries for kdump according to the analysis, other than the
> > >> new-allocated domain id. Let me ponder more on this.
> > > Flushing the context entry only is fine. The old domain-id will not be
> > > re-used anyway, so there is no point in reading it out of the context
> > > table and flush it.
> > 
> > Do you mean to flush the context entry using the new-allocated domain id?
> > 
> > Yes, old domain-id will not be re-used as they were reserved when copy, but
> > may still be cached by in-flight DMA access.
> 
> Joerg is saying you have flushed context entry which is the ingress,
> new DMA can't get an entrance to hit the iotlb accordingly. Since you
> have bolted the ingress gate. I guess

And please code comment at the bottom of iommu_init_domains(), you can
see domain 0 is a special domain id.


~~~~~~~~~~~~~~~~~~~~~~~~~
        /*
         * If Caching mode is set, then invalid translations are tagged
         * with domain-id 0, hence we need to pre-allocate it. We also
         * use domain-id 0 as a marker for non-allocated domain-id, so
         * make sure it is not used for a real domain.
         */
        set_bit(0, iommu->domain_ids);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

And in vt-d spec, at the end of section 6.2.2 and the following
sections, you can see domain 0 is used to tag the cached entry.

I guess that's why it works with only domain 0 specified. The simple
thing to verify that is you specify another did, E.g 100 for your
flushing, see if it still works.


So, if it's just as above, v1 should be good enough.

Besides, you should use translation_pre_enabled(). If 1st kernel add
intel_iommu=off, no need to do this.

Thanks
Baoquan
> 
> > 
> > Here is what the things seem to be from my understanding, and why I want to
> > flush using the old domain id:
> > 1) In kdump mode, old tables are copied, and all the iommu caches are flushed.
> > 2) There comes some in-flight DMA before the device's new context is mapped,
> >     so translation caches(context, iotlb, etc) are created tagging old domain-id
> >     in the iommu hardware.
> > 3) At the driver probe stage, the device is reset , and no in-flight DMA will exist.
> >     Here I assumed that the device reset won't flush the old caches in the iommu
> >     hardware related to this device. I haven't found any relevant specification, please
> >     correct me if I am wrong.
> > 4) Then new context is setup, and new DMA is initiated, hit old cache that was
> >     created in 2) as currently there's no such flush action, so DMAR fault happens.
> > 
> > I already posted v2 to flush context/iotlb using the old domain-id:
> > https://lkml.org/lkml/2016/11/18/514
> > 
> > Regards,
> > Xunlei
> > 
> > >
> > > Also, please add a Fixes-tag when you re-post this patch.
> > >
> > >
> > > 	Joerg
> > >
> > 
> > 
> > _______________________________________________
> > kexec mailing list
> > kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
> > http://lists.infradead.org/mailman/listinfo/kexec
