From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH] iommu/arm-smmu: Allow size of stage 1 output to max
	possible value for sateg 2 bypass
Date: Mon, 1 Sep 2014 16:12:34 +0100
Message-ID: <20140901151234.GE24594@arm.com>
References: <1409162541-3940-1-git-send-email-c.tirumalesh@gmail.com>
	<20140901114238.GB24594@arm.com>
	<CALuQcNn-d3_fQaygtObzeZL7OxU8BsstKMmCmpQMHEOF31b1RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CALuQcNn-d3_fQaygtObzeZL7OxU8BsstKMmCmpQMHEOF31b1RA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: tirumalesh chalamarla <c.tirumalesh-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Prasun.Kapoor-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <Prasun.Kapoor-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, Tirumalesh Chalamarla <tchalamarla-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org" <tchalamarla-M3mlKVOIwJVv6pq1l3V1OdBPR1lH4CV8@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Mon, Sep 01, 2014 at 02:49:58PM +0100, tirumalesh chalamarla wrote:
> On Mon, Sep 1, 2014 at 4:42 AM, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org> wrote:
> > Assuming I understand the problem correctly, why not simply remove the
> > truncation from the existing code (untested patch below)? Does that not
> > work for you?
> >
> 
> This will not restrict stage 1 out put to VA_BITS, even for two level
> translations. this results in non debuggable problems
> if we configure incorrectly.  there is no harm in checking the
> condition for nested translations, as i did in my patch.

Right, but restricting stage-1 output to VA_BITS doesn't make sense;
remember it's not the same kernel writing the stage-1 and stage-2 tables.

Will
