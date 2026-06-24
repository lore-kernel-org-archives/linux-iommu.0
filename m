Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01EAE3A1B5;
	Wed, 24 Jun 2026 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782296184; cv=none; b=X3shp1SeZLKIW2z5bDkJ5PrceNLHGDnG28pkfbhhcZPWzx+XpOQoMORKYEYdeIX/BltgyL2m75VHmdkkFpVdM8MsDLTfCpGuvRs7yKNsafWD2R3apWSfFSIza26jRC1+2eekUi+aJ22UI2w2awCWkGHVK3mvtn+O1q98DUhMeRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782296184; c=relaxed/simple;
	bh=j8UuGJIyvmP9xPOBDHNazf2wL6EEJUXPI+1z20bDwzo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=axgmRD0on8Q4MfGk+C7MxP41nlDQVR1wwr9qGyYPCNkgQ3r146cyT/xizKWrlrYSTvU6SOisMoZ0YTRMlf67H//CJRTaj4ibhvQJmn2Ybs8013ss0z7WzSgHFXqFvRtZF+lSauPJTolif6deuvY20lxqkoRiOwOShdH4hZGTZUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B7jkjlYZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B7jkjlYZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E40A01F000E9;
	Wed, 24 Jun 2026 10:16:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782296182;
	bh=52jh7JTXdS/PPkJ7pb4Ja7p6UQgePUeTTMff1Q4ccjs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=B7jkjlYZ31/W0IDZ2EtI1vgQv9ahx1MLABtvG4b4p1XZw+gxnAbWFJhSe6ju0jeDC
	 TVx9CIKOe539vQBeytJTy57Xrhwolfbw6ZnS1wUW8lIU1VQVpk8kc+/ol14ScwRlkE
	 MB01+Pl4RaUD3yrlDYjH1bIhK4Uaqd/ls54Jikb76FZfCyLnJ+WZTWkLzu/f3yAUFf
	 w9xltKBPugpEvpgFLV9DQrqNwaxh78enlT+8DxdMRaPAbPd5i9x2kUxOGwVdQi4TAG
	 5ouWnmASlTQXWdwHKgrqZSm++cObqa1rGrK0I6AwucAud+gRkSAb3LU6+egiwVWIBK
	 uxP4Q7UJ1GfDg==
Message-ID: <c7b956a9-d3e8-4e18-b780-5d08f5cd2ca1@kernel.org>
Date: Wed, 24 Jun 2026 12:16:15 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dma-iommu: Introduce API to reserve IOVA regions for
 dynamically created devices
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Vishnu Reddy <busanna.reddy@oss.qualcomm.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
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
 <e9e76c9f-b3b1-4ffd-9547-183556f6bb60@kernel.org>
 <20260618151745.GD231643@ziepe.ca>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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
In-Reply-To: <20260618151745.GD231643@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/06/2026 17:17, Jason Gunthorpe wrote:
> On Thu, Jun 18, 2026 at 01:57:40PM +0200, Krzysztof Kozlowski wrote:
> 
>> Same with interrupt-map.
> 
>> There are PCIe controller nodes which have interrupt-map and no
>> interrupts property ever uses them.
> 
> PCIe is quite a different situation because we expect Linux to
> dynamically create the child nodes based on PCIe discovery, and the
> various maps are all searched based on the PCI BDF based on HW
> properties of real discovered child devices.
> 
> Here they created "vpu_bus" and create a bunch of devices for some
> reason, but they are all hard coded in the driver. It is not a dynamic
> discovery, and it is not creating "real" child devices.

Yes, true.

> 
>> Because DT person - me - told that creating child device nodes just to
>> configure iommus is abuse of DT. There are no child devices in terms of
>> hardware or firmware. The iommu ranges here are no real hardware.
> 
> That doesn't seem to be what Vishnu is saying. Review the earlier two
> emails explaining what the HW issue is here:
> 
> https://lore.kernel.org/all/bb59f07e-ca7e-f012-6a4b-0a148350b69c@oss.qualcomm.com/
> https://lore.kernel.org/all/cb37e7cc-4fb0-4c24-8f89-f6f9eb08a107@oss.qualcomm.com/
> 
> The VPU HW diagram with different IOVA requirements for different
> stream IDs seems to be an entirely HW based thing: "each context bank
> enforces a different IOVA range"
> 
> The original patches just created a 0 based IOVA space per stream and
> justified that by increasing the IOVA address space (make sense). The
> email above now says some of the streams only function with a limited
> range of IOVA because the HW uses the IOVA itself to select the
> streams (insane!)
> 
> IOW this entire device is completely mis-designed if it is going to
> easially support the Linux DMA API :( That's all HW mess, which is
> motivating hacks to try to make the Linux DMA API do something usable
> by this device.
> 
> Anyhow..
> 
> In Linux if you use DT iommus the SW sets things up so every stream
> shares the same translation. If your driver/device doesn't like that
> there is no SW way to opt out of sharing. I think that is the first
> core issue that VPU was struggling with.
> 
> If you have one "device" then I would argue the DT should describe all
> its streams using iommus in the normal way. The introduction of
> iommu-map for VPU is only being done because that is a convenient hack
> to allow Linux to unbundle the streams. It would be much harder to
> unbunble the streams directly from the DT iommus property, but that
> would probably be the cleanest, software agnostic, DT modeling.
> 
> So, if we are going to do a hack in DT to accomodate Linux, I argue to
> choose explicit child devices so VPU does not need to create a special
> bus, call of_dma_configue, or hack in new DMA API things that only it
> will ever use. Then the explicit children can properly describe how
> the HW decodes IOVA into each streams in the DT (which sounds very
> much like a HW property to me) so that Linux produces IOVA that the HW
> mangling properly routes to the expected stream.
> 
> Then the VPU driver just has to assemble itself from many struct
> devices, which I admit is also a troublesome task.
> 
>> However, said all this, since I pushed folks to come with the iommu-map
>> approach, I will revoke my disagreement to child device nodes in DT, if
>> you really believe that is the approach. IOW, I will agree to device
>> nodes in DT representing fake hardware-children, just for the sake of
>> Linux driver model limitations.
> 
> I would wait for Robin, he knows this better, but I belive this was
> broadly his point in the original email..

Thanks Jason for context and detailed arguments. Robin did not chime in
yet, but from what I understood the DT-child-node approach will be the
way we should go here.

I accept above point of view and I am fine with this, thus Vishnu and
Vikash - please go ahead with DT-child-node solution we had some time ago.

Best regards,
Krzysztof
