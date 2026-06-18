Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C9383C2781;
	Thu, 18 Jun 2026 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781783871; cv=none; b=q/ilZOPptNoEzkDhsGUW2INXZTIkOvRSceRzRqfRkeVFVVwJxh2clKghZ5ag0zLk43m5RqqWedf2+KBwSyapvgWcsr81noQU5LShQAfoEyT1xiPpI2/KgLfPJwy/9jDEQse2/9eBCiYdk3rgdOuXi6eY5MckBGAd9LkOY6O/9Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781783871; c=relaxed/simple;
	bh=5rUcpDJTnijBlJxZtbHaZV3ydzjObwjeussqtqGuEqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8BiW3yfNesx48D/0UHDynzq5dvLhUCysWNIEfVK1LCgGzdlSRB3I98zxUlpFx/GTfdfc8yluzQXMfCoSLn85UozqNlRlatvWjv3hMUHsgXEh9V/5fssQa+Hjj0CYvwhR5vERUNDVaT0acUyfudV7cFz+v302MIYJ59512vodv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=knUuLSPn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="knUuLSPn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80FEA1F000E9;
	Thu, 18 Jun 2026 11:57:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781783868;
	bh=DT0MzfXL8UMnEN+76rXoRypHa+VhLqGKHT3okpH67u0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=knUuLSPnOaRnXt+Cjz+q6JgwK5YFnAtjuOPvoW2IWUIPGR1dCEkHHUv32h2pNPBBq
	 3A6TF6xw6sET788hfzGwJgxdPldVNUmJD3n+uCwP4lnzwR2TtilmsxMqXXT1LhxBWe
	 unHDIrTryffojBXiTabNGIgWt1Yakik5C/QVrkXi+wVGSDQv+vFHe+yIwXd2ujCoN4
	 coSkxM2K8WlEujvuzwN1GTTmNUBVJUhmbeWkJYiit1kIUmV4rBkKw7osJdA2B6wPxP
	 9fzEWYfmhFWC1JROHy4MJyUUZQNk47iWtToiQMSjDBQW2Fnb4qi9mJDJU+V0B+dSuU
	 a8VZdHnNGyK+Q==
Message-ID: <e9e76c9f-b3b1-4ffd-9547-183556f6bb60@kernel.org>
Date: Thu, 18 Jun 2026 13:57:40 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-iommu: Introduce API to reserve IOVA regions for
 dynamically created devices
To: Jason Gunthorpe <jgg@ziepe.ca>,
 Vishnu Reddy <busanna.reddy@oss.qualcomm.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org
Cc: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org, will@kernel.org,
 m.szyprowski@samsung.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, dikshita.agarwal@oss.qualcomm.com
References: <20260119054936.3350128-1-busanna.reddy@oss.qualcomm.com>
 <cfd23f75-8952-4463-abd5-815b995031b0@arm.com>
 <bb59f07e-ca7e-f012-6a4b-0a148350b69c@oss.qualcomm.com>
 <20260612172649.GM1066031@ziepe.ca>
 <da77c21d-25b3-46c3-a48f-71f0549e9f5f@oss.qualcomm.com>
 <20260615125257.GS1066031@ziepe.ca>
 <dcc0d02e-91fb-ddbe-399a-0191bab94c4f@oss.qualcomm.com>
 <20260617194038.GC231643@ziepe.ca>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzSVLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnprQGtlcm5lbC5vcmc+wsGPBBMBCgA5AhsDBgsJCAcDAgYVCAIJCgsE
 FgIDAQIeAQIXgBYhBJvQfg4MUfjVlne3VBuTQ307QWKbBQJp2mE8AAoJEBuTQ307QWKbeaIP
 /ihHTkTW4KsN/DQ945JJbyu5tI0J80Wue7QyyLPglyKfhgb5cLLNPpOC8cCIJsc7+W3i2P38
 s2c1cOH6CYGE7E9ur3Vfme8NW2S2I/Z8VC7bZnzyS23wT17LrsdS/qCpx4o8U+pt/xdXDKph
 EGRYrIEmMpUWvyYzyYKGIe25FtaayIIKpq8eZYyFcp2f/sG5IkOW5uZzHPMPdcm87jU7fyuQ
 rAU2vx9r+ulUfQ/q9Z2roC/ode3l7t2pN7BCBCsUDp6JCrUyZrtT1e7EbA0ZRP3aOBNk2P2E
 DQOgJGjGdO5Yx2Y9LFtltu6JbsBJHi1syGRX3AtQYOMc4Y1WGoeZJmMlvKj2ZqqXNkcWi2DS
 IQEWB0uW6CqFsBBIMGDa+6OzdaVO/uAVXWDWml02Men3CILdI1MbVjoh8ECqYUY7OQ+JJvNN
 vnliuq5WM3Ghd3jg/LZZrxXjdIginRHFQCjIJYLKpLZWm1/iDFedcfzqRNYmTtqscdCNHW41
 oT3Z7BmO9xwdjuwBS6nmS6JJwkbf5Ot2QR4pB/DRU7ZwjT1qHe+9r9gF32wXVQatHNGK/VVu
 sfwOnkdxCWkp/qb2gdQRmZh+SedStWshigH6sNfuHBloF/q+hjMRc8b2m326OZdrbSHwY1Sz
 vti8Hn7n8NjdHO9LKB7BIdjkA9DA5WsqOuVCzsFNBFVDXDQBEADNkrQYSREUL4D3Gws46JEo
 Z9HEQOKtkrwjrzlw/tCmqVzERRPvz2Xg8n7+HRCrgqnodIYoUh5WsU84N03KlLueMNsWLJBv
 BaubYN4JuJIdRr4dS4oyF1/fQAQPHh8Thpiz0SAZFx6iWKB7Qrz3OrGCjTPcW6eiOMheesVS
 5hxietSmlin+SilmIAPZHx7n242u6kdHOh+/SyLImKn/dh9RzatVpUKbv34eP1wAGldWsRxb
 f3WP9pFNObSzI/Bo3kA89Xx2rO2roC+Gq4LeHvo7ptzcLcrqaHUAcZ3CgFG88CnA6z6lBZn0
 WyewEcPOPdcUB2Q7D/NiUY+HDiV99rAYPJztjeTrBSTnHeSBPb+qn5ZZGQwIdUW9YegxWKvX
 XHTwB5eMzo/RB6vffwqcnHDoe0q7VgzRRZJwpi6aMIXLfeWZ5Wrwaw2zldFuO4Dt91pFzBSO
 IpeMtfgb/Pfe/a1WJ/GgaIRIBE+NUqckM+3zJHGmVPqJP/h2Iwv6nw8U+7Yyl6gUBLHFTg2h
 YnLFJI4Xjg+AX1hHFVKmvl3VBHIsBv0oDcsQWXqY+NaFahT0lRPjYtrTa1v3tem/JoFzZ4B0
 p27K+qQCF2R96hVvuEyjzBmdq2esyE6zIqftdo4MOJho8uctOiWbwNNq2U9pPWmu4vXVFBYI
 GmpyNPYzRm0QPwARAQABwsF2BBgBCgAgAhsMFiEEm9B+DgxR+NWWd7dUG5NDfTtBYpsFAmna
 YUkACgkQG5NDfTtBYptX+BAApg32CkxwNucNEi8WfWA8oKkW0y8YDuY6ORMo9FWNGiT/OTy0
 vyJrLocrpn86zwfjVp+eCrssPYh8eqJfnWqmYv6ACQtHPYzPZQ3mSo8H97Z01oUxITzCxpXm
 ZkLgPIqtDPcC2E3dPM/fVxcyowM8XsaMA9wcsaUYrta8toOq2b9tKcjleKMfMrm0gQ9u7wUc
 QbLkwj6TCLOwucb07GXzLTNF9PZmaDUpKAZjMjmrW+le+SFvQbhamx0rxLWPR0NWntXpbCn+
 +ACch03p/JyTBVktxFsFyCt7pTPE1kEaeuXBTe/a2D9iQvRxRW19LvuO2e59/u1wYUiH/orz
 wbIC2S4dBsPAPihL3ztOU1yE86GPyQtSE0kU+/7snnLt4QGi6PChf3t5gnNjAzjUUovO8rgI
 c+5yN5heq5loYHgK6OQ9OlHzsPHO9e9MOQcKlFycs1pyijFGzDwdNUm/SchK8iWT2QApTx4A
 K9bCVaboTA2T77QYkRcRJYSsO1alGX0ome/hMLD1daXlkrNUp1HWa3K4iytLRXjCSIorWiGs
 n+q3krnpXu3TFkA8qtOFZMdnIiFuiq1yLT8hptsV5xh1TA2nsVvSYiaCr3q4s4BKjS/KrLDb
 qoxzw8ISjdUp4pA85vb6YLCmb39NgidD+7PmAr65lBNveIFynTgsja1rRQ4=
In-Reply-To: <20260617194038.GC231643@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 17/06/2026 21:40, Jason Gunthorpe wrote:
> On Mon, Jun 15, 2026 at 11:21:45PM +0530, Vishnu Reddy wrote:
>> Hi Jason,
>>
>> Here, the parent node does not have an iommus property — it only has iommu-map,
>> like example below:
>>
>> iommu-map = <0x0 &apps_smmu 0x1940 0x0 0x1>,  /* function_id 0 → SID 0x1940 */
>>             <0x1 &apps_smmu 0x1943 0x0 0x1>,  /* function_id 1 → SID 0x1943 */
>>             <0x2 &apps_smmu 0x1944 0x0 0x1>;  /* function_id 2 → SID 0x1944 */
>>
>> When the parent device is probed, of_dma_configure() is called, which
>> internally invokes of_dma_configure_id() with NULL as the function ID. Since
>> there is no iommus entry, no stream ID gets mapped to the parent device.
> 
> Sure, but it still did of_dma_configure on the parent..
> 
>> The child devices are created at runtime and have no of_node of their own. The
>> only place the iommu-map property exists is on the parent's of_node. So when
>> configuring a child device, we pass the parent's of_node along with the child's
>> specific function_id — this is how of_dma_configure_id() finds and maps the
>> correct stream ID to the child device only.
> 
> The whole thing seems like the wrong way to use DT to me. Having an
> iommu-map in the dt that no iommus property ever uses strikes me as
> abusive.

Same with interrupt-map.

There are PCIe controller nodes which have interrupt-map and no
interrupts property ever uses them.

https://web.git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/freescale/imx8mm.dtsi?h=v7.1#n1340

There might be DT children but they still won't have interrupts at all.

> 
> Then hard coding the ID table and manually creating the missing
> struct devices in C code is a throw back to board files :(

There are no distinctive, specific child devices here. Devices in terms
of hardware. There are no resources of children, they are not real
hardware devices.

You mentioned earlier that DT description is incomplete or not proper. I
disagree. Adding any child here just to configure IOMMU differently is
abuse of DT - creating fake device nodes to overcome somehow Linux
limitations.

> 
> Of course it doesn't fully work, it was never intended to be used like
> this.
> 
> Why the resistance to doing DT properly with actual iommus and dma
> ranges for each and every stream your device needs?

Because DT person - me - told that creating child device nodes just to
configure iommus is abuse of DT. There are no child devices in terms of
hardware or firmware. The iommu ranges here are no real hardware.

However, said all this, since I pushed folks to come with the iommu-map
approach, I will revoke my disagreement to child device nodes in DT, if
you really believe that is the approach. IOW, I will agree to device
nodes in DT representing fake hardware-children, just for the sake of
Linux driver model limitations.


Best regards,
Krzysztof
