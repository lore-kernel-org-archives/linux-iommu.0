From: Joerg Roedel <joro@8bytes.org>
Subject: Re: [v4 2/8] iommu, x86: Define new irte structure for VT-d
 Posted-Interrupts
Date: Tue, 31 Mar 2015 17:16:43 +0200
Message-ID: <20150331151643.GF22683@8bytes.org>
References: <1422864424-19411-1-git-send-email-feng.wu@intel.com>
 <1422864424-19411-3-git-send-email-feng.wu@intel.com>
 <20150323115754.GN4441@8bytes.org>
 <E959C4978C3B6342920538CF579893F00245824F@SHSMSX104.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <E959C4978C3B6342920538CF579893F00245824F@SHSMSX104.ccr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Wu, Feng" <feng.wu@intel.com>
Cc: "dwmw2@infradead.org" <dwmw2@infradead.org>, "jiang.liu@linux.intel.com" <jiang.liu@linux.intel.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Mar 24, 2015 at 02:32:01AM +0000, Wu, Feng wrote:
> > I think it is better to put this as a union into struct irte. It saves
> > memory and unnecessary casting in later patches.
> 
> Thanks for the comments!

Thinking more about this, I think its probably fine to keep the two
versions of the irte seperate like in this patch-set. It allows to
update the non-posted irte when the posted irte is active at the moment
and makes the transition between both irte variants easier.

But what I still don't like is the type casting necessary when calling
modify_irte(). Can you abstract this and put the decission whether irte
or irte_pi is set active into modify_irte? It required to change the
interface of modify_irte, but that should be easy.


	Joerg
