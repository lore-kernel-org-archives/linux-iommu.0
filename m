From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 4/4] iommu: Add domain window handling functions
Date: Mon, 4 Feb 2013 17:36:20 -0600
Message-ID: <1360020980.14901.17@snotra>
References: <1359582228-21552-1-git-send-email-joro@8bytes.org>
	<1359582228-21552-5-git-send-email-joro@8bytes.org>
	<C5ECD7A89D1DC44195F34B25E172658D3670ED@039-SN2MPN1-013.039d.mgd.msft.net>
	<20130204130214.GN25591@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130204130214.GN25591@8bytes.org> (from joro@8bytes.org on
	Mon Feb  4 07:02:14 2013)
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Sethi Varun-B16395 <B16395@freescale.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wood Scott-B07421 <B07421@freescale.com>, Yoder Stuart-B08248 <B08248@freescale.com>
List-Id: iommu@lists.linux-foundation.org

On 02/04/2013 07:02:14 AM, Joerg Roedel wrote:
> On Thu, Jan 31, 2013 at 09:32:26AM +0000, Sethi Varun-B16395 wrote:
> > We need a mechanism to determine the maximum number of subwindows  
> supported by PAMU. How about representing it in the iommu_domain  
> structure:
> > struct  iommu_domain {
> > 	struct iommu_ops *ops;
> > 	void *priv;
> > 	iommu_fault_handler_t handler;
> > 	void *handler_token;
> > 	struct iommu_domain_geometry geometry;
> > 	u32 max_sub_windows; -----> maximum number of sub windows  
> supported by the hardware.
> > }
> 
> I`ll leave that flag to the private-data of the IOMMU domain. Instead  
> I
> added a DOMAIN_ATTR_WINDOWS attribute to get/set the number of
> subwindows. I'll post the updated patch-set soon.

If it's private data, how does the caller know what sort of geometry it  
can request?

-Scott
