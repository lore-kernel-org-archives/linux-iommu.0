From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2 1/4] dma-mapping: Add devm_ interface for
 dma_map_single()
Date: Wed, 4 Jun 2014 10:04:08 -0400
Message-ID: <20140604140408.GC5004@htj.dyndns.org>
References: <1401606077-1739-1-git-send-email-eli.billauer@gmail.com>
 <1401606077-1739-2-git-send-email-eli.billauer@gmail.com>
 <538E3D04.9060808@samsung.com> <20140603233907.GB23880@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <driverdev-devel-bounces@linuxdriverproject.org>
Content-Disposition: inline
In-Reply-To: <20140603233907.GB23880@8bytes.org>
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

On Wed, Jun 04, 2014 at 01:39:07AM +0200, Joerg Roedel wrote:
> I fully agree with the points Shuah brought up here. I don't think it is
> a good idea to add this kind of resource management to runtime-allocated
> (and de-allocated) resources of device drivers.
>
> Also DMA handles are not something that could be garbage collected at
> driver unload time. They are a limited resource that may be used up at
> some point. And the whole point of a devm-API is that code can be
> simpler because we don't need to de-allocate everything on the
> error-path or at unload time, no?

Hmmm?  Don't we have drivers which map dma buffers on device init and
release them on exit?  For dynamic usages, its usefulness is limited
especially given that dynamic tracking of buffers usually would
involve tracking of other information too in addition to dma buffer
pointer themselves.  If alloc on init and free on exit is a very rare
usage pattern, I have no objection against not adding devm interface
for dma mappings.

Thanks.

-- 
tejun
