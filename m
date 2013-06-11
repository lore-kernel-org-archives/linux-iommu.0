From: Jassi Brar <jaswinder.singh@linaro.org>
Subject: Re: [PATCH 2/9] dma: pl330: use dma_addr_t for describing bus
 addresses
Date: Tue, 11 Jun 2013 10:09:09 +0530
Message-ID: <CAJe_Zhf2yjKC=SrC0vOx-0VYKs4D9ewKwyM_ip6it7tFM8hQcg@mail.gmail.com>
References: <1370889285-22799-1-git-send-email-will.deacon@arm.com>
 <1370889285-22799-3-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1370889285-22799-3-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Will Deacon <will.deacon@arm.com>
Cc: Vinod Koul <vinod.koul@intel.com>, iommu@lists.linux-foundation.org, device-tree <devicetree-discuss@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: iommu@lists.linux-foundation.org

On 11 June 2013 00:04, Will Deacon <will.deacon@arm.com> wrote:
> The microcode bus address (pl330_dmac.mcode_bus) is currently a u32,
> which fails to compile when building on a system with 64-bit bus
> addresses.
>
> This patch uses dma_addr_t to represent the address instead.
>
Acked-by: Jassi Brar <jaswinder.singh@linaro.org>
