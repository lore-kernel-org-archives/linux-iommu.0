From: Murali Karicheri <m-karicheri2-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH - v7] of: Move of_dma_configure() to device.c to help
	re-use
Date: Tue, 3 Mar 2015 09:58:58 -0500
Message-ID: <54F5CC32.6050603@ti.com>
References: <1425333548-8802-1-git-send-email-m-karicheri2@ti.com>
	<CAErSpo7MsxgVZyhpijRzVN7mVNcbN7M4A4W-UKaNs4AnmGrB6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAErSpo7MsxgVZyhpijRzVN7mVNcbN7M4A4W-UKaNs4AnmGrB6g-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Bjorn Helgaas <bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
Cc: "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "open
	list:INTEL IOMMU (VT-d)" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-arm <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 03/02/2015 10:43 PM, Bjorn Helgaas wrote:
> On Mon, Mar 2, 2015 at 3:59 PM, Murali Karicheri<m-karicheri2-l0cyMroinI0@public.gmane.org>  wrote:
>> Move of_dma_configure() to device.c so it can be re-used for PCI devices to
>> obtain DMA configuration from DT.  Also add a second argument so that for
>> PCI, the DT node of root bus host bridge can be used to obtain the DMA
>> configuration for the slave PCI device.
>>
>> Tested-by: Suravee Suthikulpanit<Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>  (AMD Seattle)
>> Signed-off-by: Murali Karicheri<m-karicheri2-l0cyMroinI0@public.gmane.org>
>> Signed-off-by: Bjorn Helgaas<bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org>
>> Reviewed-by: Catalin Marinas<catalin.marinas-5wv7dgnIgG8@public.gmane.org>
>> Acked-by: Will Deacon<will.deacon-5wv7dgnIgG8@public.gmane.org>
>> CC: Joerg Roedel<joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
>> CC: Grant Likely<grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> CC: Rob Herring<robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
>> CC: Russell King<linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
>> CC: Arnd Bergmann<arnd-r2nGTMty4D4@public.gmane.org>
>> ---
>>   - Based on the existing patch applied to arm-pci/pci/iommu for pci next (Bjorn)
>>   - Fixed the build issue reported on ARCH=x86_64
>
> Hi Murali,
>
> Can you please repost the entire series with fixed patches?  It's
> easier for me to reapply the whole thing at once than it is to keep
> track of and fiddle with individual patches.
>
> Bjorn
Ok Fine. Will post now.

Murali

-- 
Murali Karicheri
Linux Kernel, Texas Instruments
