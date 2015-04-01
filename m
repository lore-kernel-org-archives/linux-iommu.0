From: "Wu, Feng" <feng.wu-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: RE: [v4 2/8] iommu, x86: Define new irte structure for VT-d
	Posted-Interrupts
Date: Wed, 1 Apr 2015 08:51:47 +0000
Message-ID: <E959C4978C3B6342920538CF579893F00248433E@SHSMSX104.ccr.corp.intel.com>
References: <1422864424-19411-1-git-send-email-feng.wu@intel.com>
	<1422864424-19411-3-git-send-email-feng.wu@intel.com>
	<20150323115754.GN4441@8bytes.org>
	<E959C4978C3B6342920538CF579893F00245824F@SHSMSX104.ccr.corp.intel.com>
	<20150331151643.GF22683@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20150331151643.GF22683-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org" <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org" <jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Joerg Roedel [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
> Sent: Tuesday, March 31, 2015 11:17 PM
> To: Wu, Feng
> Cc: dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org; jiang.liu-VuQAYsv1563Yd54FQh9/CA@public.gmane.org;
> iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
> Subject: Re: [v4 2/8] iommu, x86: Define new irte structure for VT-d
> Posted-Interrupts
> 
> On Tue, Mar 24, 2015 at 02:32:01AM +0000, Wu, Feng wrote:
> > > I think it is better to put this as a union into struct irte. It saves
> > > memory and unnecessary casting in later patches.
> >
> > Thanks for the comments!
> 
> Thinking more about this, I think its probably fine to keep the two
> versions of the irte seperate like in this patch-set. It allows to
> update the non-posted irte when the posted irte is active at the moment
> and makes the transition between both irte variants easier.
> 
> But what I still don't like is the type casting necessary when calling
> modify_irte(). Can you abstract this and put the decission whether irte
> or irte_pi is set active into modify_irte? It required to change the
> interface of modify_irte, but that should be easy.
> 

Sound good! Then we can keep the difference inside modify_irte().

BTW, could you please have a look at other patches in this series?

Thanks,
Feng

> 
> 	Joerg
