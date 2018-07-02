From: Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v4 1/2] ARM: dma-mapping: Set proper DMA ops in
 arm_iommu_detach_device()
Date: Mon, 2 Jul 2018 08:34:16 -0700
Message-ID: <20180702153416.GA8079@infradead.org>
References: <20180530140625.21247-1-thierry.reding@gmail.com>
 <20180530140625.21247-2-thierry.reding@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20180530140625.21247-2-thierry.reding@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thierry Reding <thierry.reding@gmail.com>
Cc: nouveau@lists.freedesktop.org, Joerg Roedel <joro@8bytes.org>, Russell King <linux@armlinux.org.uk>, dri-devel@lists.freedesktop.org, Christoph Hellwig <hch@infradead.org>, Jordan Crouse <jcrouse@codeaurora.org>, iommu@lists.linux-foundation.org, Ben Skeggs <bskeggs@redhat.com>, Daniel Vetter <daniel@ffwll.ch>, linux-tegra@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, linux-arm-kernel@lists.infradead.org
List-Id: iommu@lists.linux-foundation.org

Looks good:

Acked-by: Christoph Hellwig <hch@lst.de>
