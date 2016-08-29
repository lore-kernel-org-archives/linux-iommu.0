From: Haggai Eran <haggaie-VPRAkNaXOzVWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCHv9 0/6] dmaengine: rcar-dmac: add iommu support for slave
	transfers
Date: Mon, 29 Aug 2016 16:11:59 +0300
Message-ID: <5863544c-ecde-a880-2468-486e22c584ac@mellanox.com>
References: <20160810112219.17964-1-niklas.soderlund+renesas@ragnatech.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20160810112219.17964-1-niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: =?UTF-8?Q?Niklas_S=c3=b6derlund?= <niklas.soderlund+renesas-1zkq55x86MTxsAP9Fp7wbw@public.gmane.org>
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

On 8/10/2016 2:22 PM, niklas.soderlund+renesas at ragnatech.se (Niklas
S=F6derlund) wrote:
> Hi,
> =

> This series tries to solve the problem with DMA with device registers
> (MMIO registers) that are behind an IOMMU for the rcar-dmac driver. A
> recent patch '9575632 (dmaengine: make slave address physical)'
> clarifies that DMA slave address provided by clients is the physical
> address. This puts the task of mapping the DMA slave address from a
> phys_addr_t to a dma_addr_t on the DMA engine.
> =

> Without an IOMMU this is easy since the phys_addr_t and dma_addr_t are
> the same and no special care is needed. However if you have a IOMMU you
> need to map the DMA slave phys_addr_t to a dma_addr_t using something
> like this.

Hi,

I was wondering how this patchset compares against the
dma_map_peer_resource() patches [1]. It seems they are intended for a
similar use case, although perhaps I'm missing something.

I see in these patches dma_map_resource gets just an address, while the
dma_map_peer_resource API had instead a peer device struct, a resource
struct and an offset. This seems to help an IOMMU implementation as it
doesn't need to find the slave device from the PFN, right?

Thanks,
Haggai

[1] https://patchwork.kernel.org/patch/7033041/
