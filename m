From: Sethi Varun-B16395 <B16395@freescale.com>
Subject: RE: [PATCH 2/7] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Wed, 11 Jul 2012 13:28:40 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D13ABC3@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1342003763-8139-1-git-send-email-joerg.roedel@amd.com>
 <1342003763-8139-3-git-send-email-joerg.roedel@amd.com>
 <C5ECD7A89D1DC44195F34B25E172658D13AA64@039-SN2MPN1-013.039d.mgd.msft.net>
 <20120711121708.GF25282@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20120711121708.GF25282@amd.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Joerg Roedel <joerg.roedel@amd.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: Joerg Roedel [mailto:joerg.roedel@amd.com]
> Sent: Wednesday, July 11, 2012 5:47 PM
> To: Sethi Varun-B16395
> Cc: iommu@lists.linux-foundation.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH 2/7] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY
> attribute
> 
> Hi Sethi,
> 
> On Wed, Jul 11, 2012 at 11:47:39AM +0000, Sethi Varun-B16395 wrote:
> > I am currently working on upstreaming the Freescale IOMMU driver. As
> > discussed (with Scott Wood) a while back, this representation of the
> > GEOMETRY attribute doesn't go well with our IOMMU implementation. Our
> > representation of the geometry would be more complex and is certainly
> > modifiable.  Our IOMMU allows for creating custom DMA mappings by
> > defining a set of DMA sub windows within a given window. We need a
> > mechanism for specifying the number of DMA subwindows as a part of the
> > domain geometry. My suggestion would be to make the GEOMETRY attribute
> > implementation dependent
> 
> Yeah, we had some discussions in the past and I came to the conclusion
> that its best to wait for your code and decide then if and how to change
> the interface to better suit your needs. The interface is not exposed to
> userspace so we can easily change it.
> 
> People are waiting for this feature and I don't want to delay it further
> unless it is absolutly necessary.
The API call for setting domain attributes is an essential part of our implementation and
GEOMETRY is a critical attribute for us. I am currently working on our driver and hopefully 
should be able to submit it in the next two weeks. In my case I was planning on letting the
geometry attribute be implementation dependent.

-Varun
