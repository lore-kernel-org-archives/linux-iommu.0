From: Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH V2 0/1] Optimise IOVA allocations for PCI devices
Date: Thu, 12 Oct 2017 12:14:08 +0100
Message-ID: <c0be8925-a78d-7f9b-99c5-8a812564ce89@arm.com>
References: <1505897522-9237-1-git-send-email-tomasz.nowicki@caviumnetworks.com>
 <cda4f03f-acf5-9b74-d8f1-774065bfc94e@semihalf.com>
 <20171012100444.GI30803@8bytes.org>
 <f7210a76-399c-3767-74d0-24a98cbf7d78@caviumnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <f7210a76-399c-3767-74d0-24a98cbf7d78@caviumnetworks.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Tomasz Nowicki <tnowicki@caviumnetworks.com>, Joerg Roedel <joro@8bytes.org>, Tomasz Nowicki <tn@semihalf.com>
Cc: Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>, will.deacon@arm.com, Jayachandran.Nair@cavium.com, ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-arm-kernel@lists.infradead.org, Ganapatrao.Kulkarni@cavium.com
List-Id: iommu@lists.linux-foundation.org

On 12/10/17 11:08, Tomasz Nowicki wrote:
> Hi Joerg,
> 
> On 12.10.2017 12:04, Joerg Roedel wrote:
>> Hi Tomasz,
>>
>> On Thu, Oct 12, 2017 at 11:40:27AM +0200, Tomasz Nowicki wrote:
>>> Can you please have a look and see if you are fine with this patch?
>>
>> How do these changes relate to Robin's IOVA optimizations already in the
>> iommu-tree?
>>
> 
> This is another optimization patch which does not conflict with Robin's
> patches.
> 
> Robin, please correct me if I am wrong.

Yup, I've had Tomasz' patch included in my iommu/iova branch for a
while, and the "Misc. IOVA tweaks" patches were actually written on top
of it.

This should be the final piece of the puzzle for several arm64 server
platforms, which exacerbate the problem by using 64K pages and having
host bridge windows consume most of the 32-bit mem space.

Robin.
