From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/5] iommu/amd: Implement DOMAIN_ATTR_GEOMETRY attribute
Date: Thu, 26 Jan 2012 12:26:58 -0600
Message-ID: <4F219AF2.6070108@freescale.com>
References: <1326983405-319-1-git-send-email-joerg.roedel@amd.com> <201201191646.13798.laurent.pinchart@ideasonboard.com> <20120119160739.GB2205@amd.com> <201201191727.10176.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201201191727.10176.laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Joerg Roedel <joerg.roedel@amd.com>, iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Ohad Ben-Cohen <ohad@wizery.com>, David Woodhouse <dwmw2@infradead.org>, David Brown <davidb@codeaurora.org>, Tony Lindgren <tony@atomide.com>, Stuart Yoder <b08248@gmail.com>, Hiroshi Doyu <hdoyu@nvidia.com>
List-Id: iommu@lists.linux-foundation.org

On 01/19/2012 10:27 AM, Laurent Pinchart wrote:
> Hi Joerg,
> 
> On Thursday 19 January 2012 17:07:39 Joerg Roedel wrote:
>> On Thu, Jan 19, 2012 at 04:46:13PM +0100, Laurent Pinchart wrote:
>>>> +struct iommu_domain_geometry {
>>>> +	u64 aperture_start;	/* First address that can be mapped    */
>>>> +	u64 aperture_end;	/* Last address that can be mapped     */
>>>
>>> Would it make sense to use a platform-dependent type that represents
>>> physical addresses instead of u64 ?
>>
>> Well, u64 is a catch-all datatype which should suit all drivers. Is this
>> a problem at ARM?
> 
> No, it's not a problem for ARM, at least to my knowledge. It just struck me as 
> weird, as we have specific data types for other kinds of addresses (such as 
> dma_addr_t).

If we want to be able to expose these attribute structs to userspace via
vfio, we'll want to stick with fixed size types.

-Scott
