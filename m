Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160AD326954;
	Mon, 19 Jan 2026 12:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768827120; cv=none; b=tVc+9nzGCkNgrxOIjDG1Afuolxz6NQceHq/dsE8QbEIIa3LRGS2Qui5BWc1hZQ7n/fECE9wvuxCDXXv5IlNA8As+yn7tCUcRdFp6BwlueohylkgoJ/Rs+cQyXmjSmySVXXHWpy/vLlF8FOZgl3skNxQ9G0HLho+sMcCvrEGA9G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768827120; c=relaxed/simple;
	bh=r2ff9uDL8xt8n0rYya4z5qBtNjY8LP95g1UfN4rnFqE=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=PjymOdw/kJUtggvu8IhaAVFT3UafFF66VgzgZU3y2v0MPkjtgyBjGlHbSo8EX3RMXm3KSD+YqJg3J9YZgu91QJxGnp8IbVn1DntbyJA7QLjAHy0FBUNd1gajx43CURq8mBfs0PIo/WYVRt73fP4sYyBygR1AZYPwLLoYLAf/gKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.17.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from [192.168.0.66] ([88.171.60.104]) by mrelayeu.kundenserver.de
 (mreue108 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1N6KQZ-1vtGwY2aMb-00w7w0; Mon, 19 Jan 2026 13:51:43 +0100
Message-ID: <87fb14ce-d708-414c-8b38-4195b7dd65a3@green-communications.fr>
Date: Mon, 19 Jan 2026 13:51:42 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: iommu@lists.linux.dev, linux-pci@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Bjorn Helgaas <bhelgaas@google.com>, "Rob Herring (Arm)" <robh@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>, Joerg Roedel <joro@8bytes.org>,
 regressions@lists.linux.dev
References: <a1d926f0-4cb5-4877-a4df-617902648d80@green-communications.fr>
 <eb94b379-6e0b-4beb-aaa7-413a4e7f04b9@green-communications.fr>
 <3780eb61-68e2-42ce-939e-7458cd3a63cb@green-communications.fr>
 <20260116171048.GP961588@nvidia.com>
Content-Language: en-US
From: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Autocrypt: addr=Nicolas.Cavallari@green-communications.fr; keydata=
 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
Subject: Re: [REGRESSION] Re: imx8 PCI regression since "iommu: Get DT/ACPI
 parsing into the proper probe path"
In-Reply-To: <20260116171048.GP961588@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:gOhvnN7z0uHCNgwQGGM9CIBM1Oz3un92068MxFN97zndh8SR9CX
 IVySgViSQp9kfyE4gyZLmhHtfTvcByvw5XKHFUU91+b4AaSmk8UfKA1YXEhAOx9EWF3AQFy
 d5/tQ+t9+F+UfAsQvH8KFSikCHokx9DPzqqhBvMFc8CZ7siK2OF5xiKdJ4am7OSzA7vimug
 TxBH6gHAI8vEi50TcHDMg==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3eTKXoM5C8s=;QdAjAqnEeRrgERg2zvsdwwDjkWj
 a1F6llPxzqpxRYaFh3byfPckq9gSqUbC8Zj+kgxuyDmcB8KcGN5MLGxaG3IIs5q+ZL8moU3d5
 HDQZx/yja7JTKCbOfu0AyesgLcO+syw5BtnzQ1NuOkWP8M4kMJw4/sOELS4qc2j5toaLnPEMS
 PcH/5Ua5eC8WDUX3Zsi5tR8pcK+EvqWieko7iOREVMN1JhWkj8FKbsdYCIxJcpk7c2qvXi0ue
 piTru8zkGa0rOTrjcb+eWMm0Mz1QsgjsPLgwPC81fx0OIm5Nc4acg/n1FAC4FkQqxqWCud8zx
 knzaHsXQ8DES6yFW5u/IsPwmuD3tK6CehGJs35n2oTDcVn2IN20NPhehld8dtjaTTzePVTc7x
 GMCMOiemkKTR5JsEX+KR76Xzk7Cfa5b42wWmJZ9IEMX0C5ole5VIhwXE+YbUo+sDDsaPLVzan
 11lptVGh6E35jMOYAE2tzBpkLstWXg2wGjS4Zs4d/ZknC+Kcr97xqwMVQelLTxCjqoFMKy1BQ
 EEax5cqwiSQ0YbAUWEmy7zkeKBrkhmu9imRXgp+idHN+XTnZcAhU+oLZO8hEHiYLFxx7jLA62
 y+yP2tdcsugTJFU6Sc3lRpCXSDCt1IgCETtywq7Z7NM85qISGXzE+hh7IelvGhiMCVlznWqSr
 S6cDjay75meyvzWBstd05QRvurXYkLzc/38LJXamVqztl/bqBKK0tiKHl9Fz02awjnXKmCzhB
 UTLOM4gK9AKNZL+s5SPnRZjSZnoPZf3+yfT9izO2x+HVUU4Crh0oWidRFsU+3Ex2OM5QhBgdC
 HnbcRgfGH6VZuFC+hXaDwoI9/9ldUwdV3EJcB2BvCIng5e3+cpU+H5n2iYMCHwCvRoAJ0RvOO
 eyfmG2LeGTBM3PB4/SGtN/m5Qo/76Vo3pwZp4qJ2E92hOyXD2H6520cNaa7IbKHMejEFamVcM
 //Meb1SSq3xgmMk3v90qrWh5DAnyK/5DGjCVdJG7Cxtp0KmxsUr2Vkuq9jkPNArApsWO3xaOO
 jEa+2U6mrcUzdVyRTAPbTQUclogU3/2Kt3dgnkJ8f0cP64bENrzaJyWGyEwVmQcBbJ6v4jRc6
 O4We04mxwwR3qGSjld6MwklXxsrqVGt/lGZzrinU0/UHbjp92r+VgeQHwQhku5fawBlhnmKDp
 NI1I6pXgyFeo7CO0u47vnxhdYB29ZAM35cERsRF7UEmSB3PaOSydIv5o/2XDzGknGT1OKQewR
 pRKKjFR77gxsY9BnUEEi9o+A0QirCNg6Dp8+lgYPR8oCWGgu/W3pVDhSiWcTcpath1QCszsKy
 dEvI9h6XJMlutYDFi7VOE5iqtAzQ29Abrz6q4Jc8li0g/xJ4HZAymXs6qOCBqZBulCQDRd8a6
 oPlU1plG+iXPZpYVDEGY2UFza+lGYHADVyE62IxKOGN+e9a1Sva6h9xK0ZBnOv502j1Q524Oy
 +alQrR/1i4bW6IOWoUNYAtO/UKEJMHnz3F1VoqgvilckQs0lqAWf11qKPmX6y2B/SKqssyZM0
 upKAWvGJgZB2BrjOOishXXyVK1Qzp1cX3V+9bvYgIJRsgUvn4XE10T4RRWoT1XtmFHMPWhdoi
 V2qXK5moIXEhQl6RMvi6Hhi5Oc/arfZ1LPywxbxH/Zk5YsfrBNZ92ERrif44DcPIjHnBXUFZ9
 g0eu0ZupuzWruWLY1dAxD5g5zjjm5S51u1t+pyO5zAGSIZ1MD0UrJ6ksC5D6a4nBFT99ktQS7
 aDrQHwQ9woIsN2Q950Et65dg29GnEu2e8j/pmeA99AiB2n2ABjSqdGcc=

Le 16/01/2026 à 18:10, Jason Gunthorpe a écrit :
> On Fri, Jan 16, 2026 at 05:52:36PM +0100, Nicolas Cavallari wrote:
>> I debugged it further, it seems to be mostly a PCI issue since the system
>> does not actually have an IOMMU.
>>
>> When examining changes in the PCI configuration (lspci -vvvv), the main
>> difference is that, with the patch, Access Control Services are enabled on
>> the PCI switch.
>>
>>          Capabilities: [220 v1] Access Control Services
>>                  ACSCap: SrcValid+ TransBlk+ ReqRedir+ CmpltRedir+
>> UpstreamFwd+ EgressCtrl+ DirectTrans+
>> -               ACSCtl: SrcValid- TransBlk- ReqRedir- CmpltRedir-
>> UpstreamFwd- EgressCtrl- DirectTrans-
>> +               ACSCtl: SrcValid+ TransBlk- ReqRedir+ CmpltRedir+
>> UpstreamFwd+ EgressCtrl- DirectTrans-
>>
>> If I manually patch the config space in sysfs and re-disable ACS on the port
>> connected to the LAN7430, I cannot reproduce the problem.  In fact,
>> disabling only ReqRedir is enough to work around the issue.
> 
> My guess would be your system has some kind of address alias going on?
> 
> Assuming you are not facing an errata, ACS generally changes the
> routing of TLPs so if you have a DMA address that could go to two
> different places then messing with ACS will give you different
> behaviors.
> 
> In specific when you turn all those ACS settings you cannot do P2P
> traffic anymore. If your system expects this for some reason then you
> must use the kernel command line option to disable acs.
> 
> If you are just doing normal netdev stuff then it is doubtful that you
> are doing P2P at all, so I might guess a bug in the microchip ethernet
> driver doing a wild DMA? Stricter ACS settings cause it to AER and the
> device cannot recover?

Yes, i'm just running network throughput tests (iperf3) on eth1 while wlan0 is 
idling, and those are the only two peripheral on the PCI bus. I don't think 
there are anything unusual going on (P2P or vendor commands).

Bit it turns out there is an errata for the Pericom PI7C9X2G404 switch that 
matches my problem, and there is already a workaround in the kernel, but it does 
not match my PCI ids:

   DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2404,
                            pci_fixup_pericom_acs_store_forward);
   DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2404,
                            pci_fixup_pericom_acs_store_forward);
   DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2304,
                            pci_fixup_pericom_acs_store_forward);
   DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2304,
                            pci_fixup_pericom_acs_store_forward);
   DECLARE_PCI_FIXUP_ENABLE(PCI_VENDOR_ID_PERICOM, 0x2303,
                            pci_fixup_pericom_acs_store_forward);
   DECLARE_PCI_FIXUP_RESUME(PCI_VENDOR_ID_PERICOM, 0x2303,
                            pci_fixup_pericom_acs_store_forward);

While my device is 12d8:b404 and lspci still identifies it as PI7C9X2G404:

01:00.0 PCI bridge [0604]: Pericom Semiconductor PI7C9X2G404 EV/SV PCIe2 
4-Port/4-Lane Packet Switch [12d8:b404] (rev 01) (prog-if 00 [Normal decode])

Adding this ID to the quirks.c list fixes the issue. I'll send a patch.
