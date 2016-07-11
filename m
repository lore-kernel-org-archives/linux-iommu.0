From: Wan Zongshun <vw@iommu.org>
Subject: Re: [PATCH] iommu/amd: Fix unity mapping initialization race
Date: Mon, 11 Jul 2016 17:25:29 +0800
Message-ID: <57836609.5060406@iommu.org>
References: <1467820838-5059-1-git-send-email-joro@8bytes.org>
 <57823445.1020808@iommu.org> <20160711071959.GB12639@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <20160711071959.GB12639@8bytes.org>
Sender: stable-owner@vger.kernel.org
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, Joerg Roedel <jroedel@suse.de>, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: iommu@lists.linux-foundation.org



On 2016=E5=B9=B407=E6=9C=8811=E6=97=A5 15:19, Joerg Roedel wrote:
> On Sun, Jul 10, 2016 at 07:40:53PM +0800, Wan Zongshun wrote:
>> Do you mean we need enable the V and TV bits to DTE entry after all
>> DTEs tables were initialized completely?
>
> Yes, this is what my patch does and what fixes the bug that was
> reported on machines which have unity-mapping entries.

Okay, this patch should also better to general case not only unity-mapp=
ing.

How about the interrupt remap function? Do we need same considering for=
=20
IV bit enable for interrupt remap?

>
>> I checked this function 'init_device_table_dma', and find it just se=
t
>> V and TV bit, to set translation info valid and DTE bits127:1 valid.
>
> Right, if no other bits are set this blocks all DMA from the gives
> device-id.

Sorry, why you still say this 'init_device_table_dma' can block DMA?
I just think this function will enable DMA transfer, since  we set the =
V=20
and TV bits, right? or I misunderstand what "block DMA" mean?

>
>> So I just think all things it should to do are to allow DMA access,
>> GPA-to-SPA translation should be active, why you add function
>> comments below is to not allow DMA access and suppress all page
>> faults?
>>
>> /*
>>   * Init the device table to not allow DMA access for devices and
>>   * suppress all page faults
>>   */
>
> Yeah, that comment needs to be updated. Not all DMA is blocked and
> page-faults are not suppressed at all. Thanks for noticing.
>
>
>
> 	Joerg
>
>
