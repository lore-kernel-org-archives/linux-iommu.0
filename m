From: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 5/6] dma-mapping: support fsl-mc bus
Date: Mon, 5 Mar 2018 16:08:14 +0100
Message-ID: <20180305150814.GA15918@lst.de>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com> <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1520260166-29387-6-git-send-email-nipun.gupta@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Nipun Gupta <nipun.gupta@nxp.com>
Cc: will.deacon@arm.com, robin.murphy@arm.com, mark.rutland@arm.com, catalin.marinas@arm.com, iommu@lists.linux-foundation.org, robh+dt@kernel.org, hch@lst.de, m.szyprowski@samsung.com, gregkh@linuxfoundation.org, joro@8bytes.org, leoyang.li@nxp.com, shawnguo@kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, bharat.bhushan@nxp.com, stuyoder@gmail.com, laurentiu.tudor@nxp.com
List-Id: iommu@lists.linux-foundation.org

We should not add any new hardocded busses here.  Please mark them in
OF/ACPI.
