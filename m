From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/4] dma-mapping: Add devm_ interface for
 dma_map_single()
Date: Wed, 4 Jun 2014 10:14:16 -0400
Message-ID: <20140604141416.GD5004@htj.dyndns.org>
References: <1401606077-1739-1-git-send-email-eli.billauer@gmail.com>
 <1401606077-1739-2-git-send-email-eli.billauer@gmail.com>
 <538E3D04.9060808@samsung.com> <20140603233907.GB23880@8bytes.org>
 <20140604140408.GC5004@htj.dyndns.org>
 <20140604141211.GC23880@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20140604141211.GC23880@8bytes.org>
List-Unsubscribe: <http://driverdev.linuxdriverproject.org/mailman/options/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=unsubscribe>
List-Archive: <http://driverdev.linuxdriverproject.org/pipermail/driverdev-devel>
List-Post: <mailto:driverdev-devel@linuxdriverproject.org>
List-Help: <mailto:driverdev-devel-request@linuxdriverproject.org?subject=help>
List-Subscribe: <http://driverdev.linuxdriverproject.org/mailman/listinfo/driverdev-devel>,
 <mailto:driverdev-devel-request@linuxdriverproject.org?subject=subscribe>
Errors-To: driverdev-devel-bounces@linuxdriverproject.org
Sender: driverdev-devel-bounces@linuxdriverproject.org
To: Joerg Roedel <joro@8bytes.org>
Cc: devel@driverdev.osuosl.org, Shuah Khan <shuah.kh@samsung.com>, discuss@x86-64.org, gregkh@linuxfoundation.org, Eli Billauer <eli.billauer@gmail.com>, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org, bhelgaas@google.com
List-Id: iommu@lists.linux-foundation.org

Hello,

On Wed, Jun 04, 2014 at 04:12:11PM +0200, Joerg Roedel wrote:
> Yes, but those drivers usually get DMA buffers at init time with the
> dma_alloc_* interfaces. The dma_map_* interfaces discussed here belong
> to the streaming DMA-API, so they are usually used for only one DMA
> transaction before dma_unmap_* is called on them.
> 
> A devm interface for the dma_alloc_* family of functions would
> actually make sense, but not for the dma_map_* functions.

Ah, okay.  Fair enough.

Thanks.

-- 
tejun
