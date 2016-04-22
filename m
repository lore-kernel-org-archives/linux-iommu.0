From: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v7 1/8] genirq/msi: Add a new MSI_FLAG_IRQ_REMAPPING flag
Date: Fri, 22 Apr 2016 14:25:57 +0200
Message-ID: <571A1855.5020008@linaro.org>
References: <1461085990-2547-1-git-send-email-eric.auger@linaro.org>
	<1461085990-2547-2-git-send-email-eric.auger@linaro.org>
	<571A04A9.1010104@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <571A04A9.1010104-5wv7dgnIgG8@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Robin Murphy <robin.murphy-5wv7dgnIgG8@public.gmane.org>, eric.auger-qxv4g6HH51o@public.gmane.org, alex.williamson-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, jason-NLaQJdtUoK4Be96aLqz0jA@public.gmane.org, marc.zyngier-5wv7dgnIgG8@public.gmane.org, christoffer.dall-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
Cc: julien.grall-5wv7dgnIgG8@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, p.fedin-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, pranav.sawargaonkar-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Robin,
On 04/22/2016 01:02 PM, Robin Murphy wrote:
> Hi Eric,
> 
> On 19/04/16 18:13, Eric Auger wrote:
>> Let's introduce a new msi_domain_info flag value, MSI_FLAG_IRQ_REMAPPING
>> meant to tell the domain supports IRQ REMAPPING, also known as Interrupt
>> Translation Service. On Intel HW this IRQ remapping capability is
>> abstracted on IOMMU side while on ARM it is abstracted on MSI controller
>> side. This flag will be used to know whether the MSI passthrough is
>> safe.
> 
> Perhaps a nitpick, but given the earlier confusion about what the IOMMU
> flag actually meant this prompts me to wonder if it's worth adjusting
> the general terminology before we propagate it further. What I think we
> actually care about is that one thing or the other "provides MSI
> isolation" rather than "supports MSI remapping", since the latter is all
> to easy to misinterpret the way we did in the SMMU drivers.

The only concern I have is https://lkml.org/lkml/2016/4/18/283 attempts
to define a PCI bus flag dubbed PCI_BUS_FLAGS_MSI_REMAP combining the
iommu & msi layer info. In that sense x86 people may not be keen of
having different terminaologies. Anyway I will follow the consensus, if any.

Best Regards

Eric


> 
> Robin.
> 
>> Signed-off-by: Eric Auger <eric.auger-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>
>> ---
>>
>> v4 -> v5:
>> - seperate flag introduction from first user addition (ITS)
>> ---
>>   include/linux/msi.h | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/include/linux/msi.h b/include/linux/msi.h
>> index 8b425c6..08441b1 100644
>> --- a/include/linux/msi.h
>> +++ b/include/linux/msi.h
>> @@ -270,6 +270,8 @@ enum {
>>       MSI_FLAG_MULTI_PCI_MSI        = (1 << 3),
>>       /* Support PCI MSIX interrupts */
>>       MSI_FLAG_PCI_MSIX        = (1 << 4),
>> +    /* Support MSI IRQ remapping service */
>> +    MSI_FLAG_IRQ_REMAPPING        = (1 << 5),
>>   };
>>
>>   int msi_domain_set_affinity(struct irq_data *data, const struct
>> cpumask *mask,
>>
> 
