From: Hanjun Guo <hanjun.guo-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH V7 08/11] drivers: acpi: Handle IOMMU lookup failure with
	deferred probing or error
Date: Fri, 03 Feb 2017 11:37:04 +0800
Message-ID: <5893FAE0.8070301@linaro.org>
References: <f2370671-ece8-fbee-de19-350dd625088f@codeaurora.org>
	<93e79759-d614-9b36-d5ab-63e8eb725009@arm.com>
	<14751205-f034-7f0d-442a-854c3909425c@codeaurora.org>
	<5ba9f366d6e25397cdef8ad95b49e199@codeaurora.org>
	<175a3798-b824-ef1a-e112-9f6f472973ae@codeaurora.org>
	<20170130143851.GJ16461@arm.com>
	<b2e50c17de156341deab9fb8e91a8dec@codeaurora.org>
	<1e048aff-0d77-b9f2-ebf8-2ba315b90ca7@codeaurora.org>
	<20170130165124.GA11712@red-moon>
	<f401e27e-d619-0eec-2401-50d8e2fc2f0f@codeaurora.org>
	<20170201185230.GA1922@red-moon>
	<3f4aa4c1e660c7e62256de9ca64fc822@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <3f4aa4c1e660c7e62256de9ca64fc822-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: Nate Watterson <nwatters-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>
Cc: linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Sinan Kaya <okaya-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, linux-acpi-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-pci-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Tomasz Nowicki <tn-nYOzD4b6Jr9Wk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On 02/03/2017 03:01 AM, Nate Watterson wrote:
> On 2017-02-01 13:52, Lorenzo Pieralisi wrote:
>>
>> I debugged the issue and Nate's fix is correct, the fact that you
>> can't it hit it with mainline is just a matter of timing because it has
>> to do with the CTX pointer value (we OR it with the existing value), so
>> it may work or not depending on how the cdptr memory allocation
>> pattern turns out to be (which explains why Nate and I can hit it with
>> simple PCI device remove/add execution too).
>>
>> So it is neither an ACPI nor an IOMMU probe deferral issue per-se,
>> fix is already queued, so it is all good.
>>
>> What about USB stalls ?
> Our fault. The USB controller was getting 48-bit IOVAs, but the
> bus it sits on only supports 44-bits so the controller's DMA
> transactions ended up targeting addresses that were never mapped.
>
> It started working once I applied the iort/dma-mapping patches I
> sent out earlier this week that use the iort memory_address_limit
> field to check if a dma_mask is sane.

OK, great, I tested this patch with platform USB device which was
working fine on Hisilicon D03, so I didn't miss anything here.

Thanks
Hanjun
