From: Christoph Hellwig <hch@lst.de>
Subject: Re: use generic dma-direct and swiotlb code for x86 V3
Date: Mon, 19 Mar 2018 16:28:40 +0100
Message-ID: <20180319152840.GA28041@lst.de>
References: <20180319103826.12853-1-hch@lst.de> <20180319152737.GK1110@char.us.oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180319152737.GK1110@char.us.oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, x86@kernel.org, Tom Lendacky <thomas.lendacky@amd.com>, David Woodhouse <dwmw2@infradead.org>, Muli Ben-Yehuda <mulix@mulix.org>, Jon Mason <jdmason@kudzu.us>, Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org

On Mon, Mar 19, 2018 at 11:27:37AM -0400, Konrad Rzeszutek Wilk wrote:
> On Mon, Mar 19, 2018 at 11:38:12AM +0100, Christoph Hellwig wrote:
> > Hi all,
> > 
> > this series switches the x86 code the the dma-direct implementation
> > for direct (non-iommu) dma and the generic swiotlb ops.  This includes
> > getting rid of the special ops for the AMD memory encryption case and
> > the STA2x11 SOC.  The generic implementations are based on the x86
> > code, so they provide the same functionality.
> 
> I need to test this on my baremertal and Xen setup - and I lost your
> git repo URL - any chance you mention point out to me so I can
> kick of a build?

git://git.infradead.org/users/hch/misc.git dma-direct-x86
