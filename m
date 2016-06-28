From: "Vesely, Jan" <Jan.Vesely-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 2/2] iommu/amd: Destroy api_lock mutex when freeing domain
Date: Tue, 28 Jun 2016 16:48:54 +0000
Message-ID: <1467132531.2590.158.camel@amd.com>
References: <1463854264-26445-1-git-send-email-jan.vesely@rutgers.edu>
	<1463854264-26445-2-git-send-email-jan.vesely@rutgers.edu>
	<1465487321.7114.0.camel@amd.com> <20160615115406.GF26566@8bytes.org>
	<1466013192.3265.74.camel@amd.com> <20160615205311.GB19822@pd.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160615205311.GB19822-fF5Pk5pvG8Y@public.gmane.org>
Content-Language: en-US
Content-ID: <3C4D694E4E14434D913FCE474348F977-asWib9pRmPqcE4WynfumptQqCkab/8FMAL8bYrjMMd8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org" <bp-Gina5bIWoIWzQB+pC5nmwQ@public.gmane.org>
Cc: "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Wed, 2016-06-15 at 22:53 +0200, Borislav Petkov wrote:
> On Wed, Jun 15, 2016 at 05:53:15PM +0000, Vesely, Jan wrote:
> > There are no specific bugs/oopses that these patches fix (that I'm
> > aware of). Both were found while I was familiarizing myself with
> > the
> > code looking for memory corruption (which turned out to be [0]).
> > Either issue would be very difficult to hit in the wild and
> > mutex_destroy is empty unless you compile using
> > CONFIG_DEBUG_MUTEXES.
> 
> See Documentation/SubmittingPatches which explains what "Fixes:"
> means.
> 
> That same file also contains info in section 2) how to write commit
> messages.
> 
> Please read it, it'll help you significantly if you're planning on
> sending more patches to LKML.

Hi,

thanks for all the hints. I'll try to revisit and update the patches
soon (might take few weeks though). Kernel development is not my
(current) job and other subsystems don't have these requirements, if
submissions need more than just git send-email of existing fixes
dedicating extra time is difficult.

Jan

> 
> > [0] https://lkml.org/lkml/2016/3/7/1087
> 
> Oh, and also, please don't use any web pages archiving lkml as
> pointers
> but the kernel.org redirector:
> 
> http://lkml.kernel.org/r/<Message-ID>;
> 
> or
> 
> http://lkml.kernel.org/g/<Message-ID>;
> 
> (that second one redirects to gmane)
> 
> HTH.
> 
