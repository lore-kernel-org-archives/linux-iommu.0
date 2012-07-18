From: Hiroshi Doyu <hdoyu@nvidia.com>
Subject: Re: [v3.6 3/3] iommu/tegra: smmu: Fix unsleepable memory allocation
 at alloc_pdir()
Date: Wed, 18 Jul 2012 10:50:35 +0200
Message-ID: <20120718.115035.519900225393247427.hdoyu@nvidia.com>
References: <20120717100901.GH4213@amd.com><20120717.152524.175499431618552821.hdoyu@nvidia.com><20120717132300.GK4213@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-omap-owner@vger.kernel.org>
In-Reply-To: <20120717132300.GK4213@amd.com>
Sender: linux-omap-owner@vger.kernel.org
To: "joerg.roedel@amd.com" <joerg.roedel@amd.com>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, "chrisw@sous-sol.org" <chrisw@sous-sol.org>, "ohad@wizery.com" <ohad@wizery.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org

"joerg.roedel@amd.com" <joerg.roedel@amd.com> wrote @ Tue, 17 Jul 2012 15:23:00 +0200:

> On Tue, Jul 17, 2012 at 02:25:24PM +0200, Hiroshi Doyu wrote:
> > The above spin_lock is always necessary. "as->lock" should be held to
> > protect "as->pdir_page". Only when "as->pdir_page" is NULL,
> > "as->pdir_page" would be allocated in "alloc_pdir()". Without this
> > lock, the following race could happen:
> > 
> > 
> > Without as->lock:
> > A:			B:
> > i == 3
> > pdir_page == NULL
> > 			i == 3
> > 	     		pdir_page == NULL
> > pdir_page = a;
> > 			pdir_page = b;	!!!!!! OVERWRITTEN !!!!!!
> >
> 
> Unless I am missing something, this is not the correct situation with my
> patch. It would look more like this:
> 
> 
>  A:					B:
>  i == 3
>  pdir_page == NULL
>  					i == 3
>  	     				pdir_page == NULL
> 
>  take as->lock
> 
>  /* race check */
>  pdir_page == NULL -> proceed		/* spinning on as->lock */
> 
>  pdir_page = a;
> 
>  release as->lock
> 
> 					 take as->lock
> 
> 					 /* race check */
> 					 pdir_page != NULL -> return
> 
> This should be fine, no? Do I miss something?

You are right. I didn't get the point of your patch. In the case that
you can return -EAGAIN, the complicated "lock,unlock,lock,check race"
is not necessary as you did.

Verified the patch w/ Tegra3 based board. Please put this into next
queue. Thanks.
