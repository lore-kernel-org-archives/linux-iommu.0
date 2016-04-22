From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH v7 1/8] genirq/msi: Add a new MSI_FLAG_IRQ_REMAPPING flag
Date: Fri, 22 Apr 2016 12:02:01 +0100
Message-ID: <571A04A9.1010104@arm.com>
References: <1461085990-2547-1-git-send-email-eric.auger@linaro.org>
 <1461085990-2547-2-git-send-email-eric.auger@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1461085990-2547-2-git-send-email-eric.auger@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Eric Auger <eric.auger@linaro.org>, eric.auger@st.com, alex.williamson@redhat.com, will.deacon@arm.com, joro@8bytes.org, tglx@linutronix.de, jason@lakedaemon.net, marc.zyngier@arm.com, christoffer.dall@linaro.org, linux-arm-kernel@lists.infradead.org
Cc: patches@linaro.org, linux-kernel@vger.kernel.org, Bharat.Bhushan@freescale.com, pranav.sawargaonkar@gmail.com, p.fedin@samsung.com, iommu@lists.linux-foundation.org, Jean-Philippe.Brucker@arm.com, julien.grall@arm.com
List-Id: iommu@lists.linux-foundation.org

Hi Eric,

On 19/04/16 18:13, Eric Auger wrote:
> Let's introduce a new msi_domain_info flag value, MSI_FLAG_IRQ_REMAPPING
> meant to tell the domain supports IRQ REMAPPING, also known as Interrupt
> Translation Service. On Intel HW this IRQ remapping capability is
> abstracted on IOMMU side while on ARM it is abstracted on MSI controller
> side. This flag will be used to know whether the MSI passthrough is
> safe.

Perhaps a nitpick, but given the earlier confusion about what the IOMMU 
flag actually meant this prompts me to wonder if it's worth adjusting 
the general terminology before we propagate it further. What I think we 
actually care about is that one thing or the other "provides MSI 
isolation" rather than "supports MSI remapping", since the latter is all 
to easy to misinterpret the way we did in the SMMU drivers.

Robin.

> Signed-off-by: Eric Auger <eric.auger@linaro.org>
>
> ---
>
> v4 -> v5:
> - seperate flag introduction from first user addition (ITS)
> ---
>   include/linux/msi.h | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/include/linux/msi.h b/include/linux/msi.h
> index 8b425c6..08441b1 100644
> --- a/include/linux/msi.h
> +++ b/include/linux/msi.h
> @@ -270,6 +270,8 @@ enum {
>   	MSI_FLAG_MULTI_PCI_MSI		= (1 << 3),
>   	/* Support PCI MSIX interrupts */
>   	MSI_FLAG_PCI_MSIX		= (1 << 4),
> +	/* Support MSI IRQ remapping service */
> +	MSI_FLAG_IRQ_REMAPPING		= (1 << 5),
>   };
>
>   int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
>
