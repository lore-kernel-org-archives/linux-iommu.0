Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D671022068D;
	Sun, 17 Aug 2025 10:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755427644; cv=none; b=tiGMXCDV5EDnWFRrNOtkpyEZm7G3hxzSWtGFjcKhWDYtUyTaRRdiNfQ0Mv9Lp3L0yFqwixiEe2MB0xg5zw99QeYDXhCeEax+Y/no9LCo/rRfe5YJzVdalaS4zJMitk/EpfWDOvko3Hq0TP/i1a+AI6qzWaQ00wEXxZXfxxFLGhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755427644; c=relaxed/simple;
	bh=I2ib/OXqX53rEewSl2SArXNdOrcnURD5+ssUMeP5k4A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=s7Vbul0W9iR9hhHZaOKKrPfDKzdSy6cWq5A5I4wtq+F+NAESDOtK0YeDqhrxFJPvpHRfeEtMtc6Pbwd7ga3oNPjtXl6ULXt4loIi8NbmXkrRl7XXSMhWFC1RyNDpzsigG5inSMKFryaGuINitQnbuBpeR4mIOzVLTN07yh/s6Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QjGM9q7n; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QjGM9q7n"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62A2C4CEEB;
	Sun, 17 Aug 2025 10:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755427643;
	bh=I2ib/OXqX53rEewSl2SArXNdOrcnURD5+ssUMeP5k4A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=QjGM9q7nSJXUG+plAyBKPeCiYay+NFV+chGfJaCtilblGRo03kdUHr9qFNgkc8iJ6
	 anqblR9hInENq7Uuu4qRNQA83z0iPv7ADUCW881ts/mqQ3AWZnPkmRhvD4u210QSfj
	 MJJixD0mqvqXagcHSxfcKfpAUScJjRMNHEcqLG+Huji6tOSzinqkYWjVeqifGk5z7/
	 CDMjgWqJrmdXJwz3hYNJC1UbPjva4T9KuVEsAu8obnILYYAAcnSQCfS8ft4Na0NCVr
	 cUlp3650rCXaI0M/XM33xOxy4VTF6Fv2hjgfha5YP26SMZSQQN0LYy+hTKGNy02fk7
	 cfpRCk+CRnwtA==
Message-ID: <56be1cd1-73cc-4733-b364-31b74f588e9b@kernel.org>
Date: Sun, 17 Aug 2025 12:47:16 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] nvme: apple: Add Apple A11 support
To: Nick Chan <towinchenmi@gmail.com>
Cc: asahi@lists.linux.dev, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Rob Herring <robh@kernel.org>, Jassi Brar <jassisinghbrar@gmail.com>,
 Neal Gompa <neal@gompa.dev>, Janne Grunau <j@jannau.net>,
 Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Sagi Grimberg <sagi@grimberg.me>,
 Hector Martin <marcan@marcan.st>, Jens Axboe <axboe@kernel.dk>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>
References: <20250811-t8015-nvme-v1-0-ef9c200e74a7@gmail.com>
 <20250811-t8015-nvme-v1-7-ef9c200e74a7@gmail.com>
Content-Language: en-US
From: Sven Peter <sven@kernel.org>
In-Reply-To: <20250811-t8015-nvme-v1-7-ef9c200e74a7@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.08.25 15:50, Nick Chan wrote:
> Add support for ANS2 NVMe on Apple A11 SoC.
> 
> This version of ANS2 is less quirky than the one in M1, and does not have
> NVMMU or Linear SQ. However, it still requires a non-standard 128-byte
> SQE.
> 
> Signed-off-by: Nick Chan <towinchenmi@gmail.com>
> ---
>   drivers/nvme/host/apple.c | 228 +++++++++++++++++++++++++++++++---------------

[...]

>   }
>   
>   static void apple_nvme_rtkit_crashed(void *cookie, const void *crashlog, size_t crashlog_size)
> @@ -284,21 +294,8 @@ static void apple_nvme_submit_cmd(struct apple_nvme_queue *q,
>   				  struct nvme_command *cmd)
>   {

Please just create a separate submit function here.
There's just not much code that's shared between the two variants.

[...]

>   }
>   
> @@ -587,10 +618,17 @@ static inline void apple_nvme_handle_cqe(struct apple_nvme_queue *q,
>   {
>   	struct apple_nvme *anv = queue_to_apple_nvme(q);
>   	struct nvme_completion *cqe = &q->cqes[idx];
> -	__u16 command_id = READ_ONCE(cqe->command_id);
>   	struct request *req;
>   
> -	apple_nvmmu_inval(q, command_id);
> +	if (!anv->hw->has_lsq_nvmmu)
> +		cqe->command_id--;
> +
> +	__u16 command_id = READ_ONCE(cqe->command_id);
> +
> +	if (anv->hw->has_lsq_nvmmu)
> +		apple_nvmmu_inval(q, command_id);
> +	else
> +		command_id++;

This entire block here looks weird. First you decrease the command_id
directly inside the shared memory structure, then you read it with
READ_ONCE to a local variable only to increase it again. Why?



Sven
