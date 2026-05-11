Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8A1A375AB2
	for <iommu@lists.linux.dev>; Mon, 11 May 2026 07:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484126; cv=none; b=f1i2++Unr2DbJeHGIDa36iSN1EPRT4OvBnYoJModPXESVrp/Khd8qkB1SKMIu34IiVH8fLaH+Vq5wCdLYesPHMSo868TlIFvhRH4ovTe5FTVivs1YtgiCx+JjBvz6jamx4VfoVmvTReWQ15wqcKkIr7CqihpaQRJIK4QK/YcV44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484126; c=relaxed/simple;
	bh=sFa6mjTeZA+YdjdzIRkDzWZvvTvkozLyw4GG3pLu5g8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JonuVIfQN1PT/baCYE3SGXrJv3jgrM0gry96yuTaRdTzWVDexEEQIpYwEFssBJU0tGPZJvyx/d0oJ59lKv+9+g8wJmZHVXsT0GkTf2s0Wc35SpFZ99NK5VYw53s2/SYqrjPEFxwKORM9X3CsNb7dHhPBhgO/j1ITJ547WZ9kI84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=R0ATEsm3; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="R0ATEsm3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1778484121;
	bh=sFa6mjTeZA+YdjdzIRkDzWZvvTvkozLyw4GG3pLu5g8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=R0ATEsm367q/tkMguEZtJEF8nYKvKUL0gTj0GCcC8/uZna4C01SpMlCgkLx2kQYk0
	 O5H+L/N0pbg0Oz228uuYg+9w152APlplCi51FE76IIfaJp3/Ao5751ugoplRzFLXdN
	 g9jttptHdPwZRptAyQbvZw67uX58bZAMEZO8TB6j7UetCC5jYJkcUdwj4+lqte2MYg
	 15hnSw+r9vFlVNlzqozLqLBGEz/SYnR94ROkin6AdwacWP9rDGsiFITS/v7IhvDaDU
	 R6ZSKwaTYUi0tjHH9K/+vSP4xTPTQtu1fjZ3KxWhwRiGMuX6Mfx3guxwFpoZ9DJw0E
	 s3THntGpbBFrw==
Received: from [100.64.1.43] (unknown [100.64.1.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: benjamin.gaignard)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8C5AE17E05FC;
	Mon, 11 May 2026 09:22:01 +0200 (CEST)
Message-ID: <36e114a3-8240-480b-a53a-6aa3810bf089@collabora.com>
Date: Mon, 11 May 2026 09:22:00 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 1/5] dt-bindings: vendor-prefixes: Add Verisilicon
To: Diederik de Haas <diederik@cknow-tech.com>, joro@8bytes.org,
 will@kernel.org, robin.murphy@arm.com, krzk+dt@kernel.org,
 conor+dt@kernel.org, heiko@sntech.de
Cc: iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, kernel@collabora.com,
 Conor Dooley <conor.dooley@microchip.com>
References: <20260415072349.44237-1-benjamin.gaignard@collabora.com>
 <20260415072349.44237-2-benjamin.gaignard@collabora.com>
 <DIEC8YT0XK4O.VAG6G4H31KJM@cknow-tech.com>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <DIEC8YT0XK4O.VAG6G4H31KJM@cknow-tech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 09/05/2026 à 19:56, Diederik de Haas a écrit :
> On Wed Apr 15, 2026 at 9:23 AM CEST, Benjamin Gaignard wrote:
>> Verisilicon Microelectronics is a company based in Shanghai, China,
>> developping hardware blocks for SoC.
>>
>> https://verisilicon.com/
>>
>> Add their name to the list of vendors.
>>
>> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>> ---
>>   Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> index ee7fd3cfe203..ebd9072300a8 100644
>> --- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> +++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
>> @@ -1761,6 +1761,8 @@ patternProperties:
>>       description: Variscite Ltd.
>>     "^vdl,.*":
>>       description: Van der Laan b.v.
>> +  "^verisilicon,.*":
>> +    description: VeriSilicon Microelectronics
>>     "^vertexcom,.*":
>>       description: Vertexcom Technologies, Inc.
>>     "^via,.*":
> FTR: Another version of this patch is already present in Linus' tree:
> c131d78840d7 ("dt-bindings: vendor-prefixes: add verisilicon")

It seems it has been merged right 7.0-rc1 that I used for this series.
Both are almost identical so we can ignore mine.

Regards,
Benjamin

