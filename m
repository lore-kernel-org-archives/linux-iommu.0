From: Sethi Varun-B16395 <B16395@freescale.com>
Subject: RE: [PATCH 5/5] iommu: Add DOMAIN_ATTR_WINDOWS domain attribute
Date: Tue, 5 Feb 2013 17:15:45 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D3792D4@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1359983924-28952-1-git-send-email-joro@8bytes.org>
 <1359983924-28952-6-git-send-email-joro@8bytes.org>
 <C5ECD7A89D1DC44195F34B25E172658D373D2B@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130205104155.GR25591@8bytes.org>
 <C5ECD7A89D1DC44195F34B25E172658D3752B1@039-SN2MPN1-013.039d.mgd.msft.net>
 <20130205130534.GS25591@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130205130534.GS25591@8bytes.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: Stuart Yoder <b08248@gmail.com>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Wood Scott-B07421 <B07421@freescale.com>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Joerg Roedel [mailto:joro@8bytes.org]
> Sent: Tuesday, February 05, 2013 6:36 PM
> To: Sethi Varun-B16395
> Cc: Stuart Yoder; iommu@lists.linux-foundation.org; linux-
> kernel@vger.kernel.org; Wood Scott-B07421
> Subject: Re: [PATCH 5/5] iommu: Add DOMAIN_ATTR_WINDOWS domain attribute
> 
> On Tue, Feb 05, 2013 at 10:52:03AM +0000, Sethi Varun-B16395 wrote:
> > DOMAIN_ATTR_PAMU_ENABLE is required to enable a particular DMA window.
> > My point is about the domain geometry, which is incomplete in case of
> > PAMU without the number of subwindows. Geometry parameters are used
> > for initializing the PAMU window settings. Individual subwindows can
> > only be enabled, once the PAMU window has been initialized using the
> > geometry settings.
> 
> I understand that. What you do is:
> 
> 	/* Set geometry */
> 	set_attr(domain, DOMAIN_ATTR_GEOMETRY);
> 
> 	/* Set number of PAMU subwindows */
> 	set_attr(domain, DOMAIN_ATTR_WINDOWS);
> 
> 	/* Commit changes to hardware and enable the window */
> 	set_attr(domain, DOMAIN_ATTR_PAMU_ENABLE);
> 
> And I don't see any problem with that. The domain_attr interface was
> introduced to cope with device specifics, we don't change global
> interface data structures for that.
> 
> 
[Sethi Varun-B16395] But, then it would be mandatory to set the DOMAIN_ATTR_WINDOWS attribute in case of PAMU. I guess that it would be implementation specific. I am fine with the API.

-Varun
