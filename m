Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F7DAD24
	for <iommu@lists.linux.dev>; Wed, 21 Jan 2026 13:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769003547; cv=pass; b=N/pzNBPGxm/Eyma/B9XhLP3a818u7pfw2ONTF1QCqswt0H6PSMM6iCdXzsIgYyR/810klNjry3P1yWMllatuFy7bCWrSQfbUcDVJLlO00V+9ayi1UrGHtv14yAGEMeUtZhXP4RJ5nrKclyXUhl9IOgwZelBJoO1BbXSEEhYixwM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769003547; c=relaxed/simple;
	bh=X7gT9UC4sQcenS3aM2Pap8cxEe9QaY6Up1+QlLfmUqw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eeOI4ei/YQ16lvVS8/KOmAp3iqqFgxAYKDZ7hpv2ncJXCXEhCa7rhrlWMwAF4fkF1g+C3ML7Aafj9c5sLRniYx2A/QfzuEVTBATuyXwbJEdq/oe3odHuRHLX+jnXaBCTL5C19+xVJzUzaaSSJwdJUcg+hW9i2nhZvM70kB1M6xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b=J8wuY4Qu; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=benjamin.gaignard@collabora.com header.b="J8wuY4Qu"
ARC-Seal: i=1; a=rsa-sha256; t=1769003534; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=gtuHqyJdIm26Gi68yEFskeWFD9ZoG4RxqzDfP4x6Du8ae40H3vouNHmQt1cjr+SuRR6//aDwJfE+FMqbNotpiJ5L8PcynHwlVfHjRwy/Kvmf9LJfWN3FKbur8MqS4gOur9suEzsY4SJVKIrDjIWSfdOXvOBSFhljA2WMNH9d+18=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1769003534; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=X7gT9UC4sQcenS3aM2Pap8cxEe9QaY6Up1+QlLfmUqw=; 
	b=G31Z5e6m9YgwA320ovrLK3t25mHfHWU8I70IFq3nqPLpoDp1JrA9V0Rlk/t7/epUORI64E+eVxSlCt+W9zxNiyYi6MKzK/DCpVSdIxt2qfpG63iz5kNne5aoQ/Jl0hviLFKIPzYjkD9rw+4Kl/dr6rukuX+KtqG1N1mGCSS4c5M=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=benjamin.gaignard@collabora.com;
	dmarc=pass header.from=<benjamin.gaignard@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1769003534;
	s=zohomail; d=collabora.com; i=benjamin.gaignard@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=X7gT9UC4sQcenS3aM2Pap8cxEe9QaY6Up1+QlLfmUqw=;
	b=J8wuY4QuC0BtQTpdyPyiss5sy28ILKTaKxLvFE/5mr3F6BlD5qPPdylW9DS9c2Zq
	QXihqonNeBPieNEid5VgFRi5QFUoLZTEXnS6KZEpecQqDKQNrOFYw9NNV/iYUWBP9rv
	j70kwKBKFTeFBknZd1L7IejUKmxXYWxWxycn+yHQ=
Received: by mx.zohomail.com with SMTPS id 176900353209289.89941655481675;
	Wed, 21 Jan 2026 05:52:12 -0800 (PST)
Message-ID: <4e0de2ff-4616-4e49-a419-1bdfb03e1430@collabora.com>
Date: Wed, 21 Jan 2026 14:52:07 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 3/6] iommu: Add verisilicon IOMMU driver
To: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>
Cc: will@kernel.org, robin.murphy@arm.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, heiko@sntech.de,
 nicolas.dufresne@collabora.com, p.zabel@pengutronix.de, mchehab@kernel.org,
 iommu@lists.linux.dev, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-media@vger.kernel.org,
 kernel@collabora.com
References: <20260114100922.149187-1-benjamin.gaignard@collabora.com>
 <20260114100922.149187-4-benjamin.gaignard@collabora.com>
 <3082a454-31dc-42a2-85a6-0fd0c87bf31b@collabora.com>
 <25htwrdapwwvumlaqlu5oywcnnbss5kjyvnv6cxrx42q7mfhuw@wyagcnc3scgf>
Content-Language: en-US
From: Benjamin Gaignard <benjamin.gaignard@collabora.com>
In-Reply-To: <25htwrdapwwvumlaqlu5oywcnnbss5kjyvnv6cxrx42q7mfhuw@wyagcnc3scgf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


Le 21/01/2026 à 12:54, Jörg Rödel a écrit :
> Note that I stop taking changes for v6.20 (except fixes) by next week. I you
> want a chance to have this code in 6.20, please make sure a v13 is in my inbox
> by tomorrow.

I have v13 ready but I'm waiting for the conclusion of the thread with Will to send it.
Thanks for the reminder.

Benjamin

>
> -Joerg
>
