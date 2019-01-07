From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v3] crypto: talitos - fix ablkcipher for CONFIG_VMAP_STACK
Date: Mon, 7 Jan 2019 18:06:15 +0100
Message-ID: <d609078d-b432-0fba-8a48-4224e62b46a9@c-s.fr>
References: <ae7b64e9415874060977e32ed48b62f1f6148084.1545346337.git.christophe.leroy@c-s.fr>
 <VI1PR0402MB3485FC2A3758BCEAC05BF3A2988E0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
 <VI1PR0402MB34853754B8F90F5904710526988E0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <VI1PR0402MB34853754B8F90F5904710526988E0@VI1PR0402MB3485.eurprd04.prod.outlook.com>
Content-Language: fr
Sender: stable-owner@vger.kernel.org
To: Horia Geanta <horia.geanta@nxp.com>, Herbert Xu <herbert@gondor.apana.org.au>, "David S. Miller" <davem@davemloft.net>
Cc: "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "stable@vger.kernel.org" <stable@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
List-Id: iommu@lists.linux-foundation.org



Le 04/01/2019 à 16:24, Horia Geanta a écrit :
> On 1/4/2019 5:17 PM, Horia Geanta wrote:
>> On 12/21/2018 10:07 AM, Christophe Leroy wrote:
>> [snip]
>>> IV cannot be on stack when CONFIG_VMAP_STACK is selected because the stack
>>> cannot be DMA mapped anymore.
>>> This looks better, thanks.
>>
>>> This patch copies the IV into the extended descriptor when iv is not
>>> a valid linear address.
>>>
>> Though I am not sure the checks in place are enough.
>>
>>> Fixes: 4de9d0b547b9 ("crypto: talitos - Add ablkcipher algorithms")
>>> Cc: stable@vger.kernel.org
>>> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
>>> ---
>>>   v3: Using struct edesc buffer.
>>>
>>>   v2: Using per-request context.
>> [snip]
>>> +	if (ivsize && !virt_addr_valid(iv))
>>> +		alloc_len += ivsize;
>> [snip]
>>>   
>>> +	if (ivsize && !virt_addr_valid(iv))
>> A more precise condition would be (!is_vmalloc_addr || is_vmalloc_addr(iv))
>>
> Sorry for the typo, I meant:
> (!virt_addr_valid(iv) || is_vmalloc_addr(iv))

As far as I know, virt_addr_valid() means the address is in the linear 
memory space. So it cannot be a vmalloc_addr if it is a linear space 
addr, can it ?

At least, it is that way on powerpc which is the arch embedding the 
talitos crypto engine. virt_addr_valid() means we are under max_pfn, 
while VMALLOC_START is above max_pfn.

Christophe

> 
>> It matches the checks in debug_dma_map_single() helper, though I am not sure
>> they are enough to rule out all exceptions of DMA API.
