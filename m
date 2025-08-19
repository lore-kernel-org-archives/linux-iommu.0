Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895131C01;
	Tue, 19 Aug 2025 16:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755620530; cv=none; b=EK8+PehkblNBFdVDFcSbAhuyfoPCZWf4rlIZKslBtnkwRzP6a4lSuAD42aZx3IcmvumzeQv9wp1ajIpEWLFrb+VMxjuzOBoRZz6dUnXz/GpDbyaTx/jHY8mklMuX5mwbyS+GYKRdM7CD0IIFjWCZm/WI4wIb+ep2+TasOoc/1ME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755620530; c=relaxed/simple;
	bh=FiIphYldsHeBQ3UwTcbZaKPuigkn3+v3w+WuFBn5DUw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ArJ9KHFFlKBE+W6UqCfbCfj97i3Fz5uTe4mm9PSCWBrh6jMHzisTvESOb4RHlFWTGO7WXapsgldtPP7SqttixtyzL39I85WLYPGn2kZLrpx+CLFNF+A2pO7B6NQEJGXSSsUwA7hZB7m/GIx36Xsyd289iZeXMMye29w1BlovxoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B4nArvdv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4nArvdv"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-244581d9866so45387215ad.2;
        Tue, 19 Aug 2025 09:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755620529; x=1756225329; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2PIjZ+DdmvuLwnrpTYlLbFeMpxoFxo/PTXBFZfTSGBg=;
        b=B4nArvdvWijTKG6FGRLUHAYmY93Eb5yWhDmVW4c1vnnIIcy5UkIE2yR8ecB6UprJzw
         OY33fr2LRYE1PQ4XadVVcD0+S+E8Y1uQi9PS9DM7zoRbHZohVR4wjzZMmNNZj8Vg/Dw6
         06887Q1yjHpBSncRZL8nBg/lVa7SP6EUpRWTr5ofyEyDb+W7eZgBcTQVdH/2+bW6Ythh
         9Cj9b3UBxZoswB+AphQboGuleoKC05wEdt2QwB4yrqc1IzkObbs9kako1Pr/n7HJU25Z
         ahAYg9GAoNfWe4OxAUBo/f2KMVBykmA6h9OueseYNjM1PIlYvfkThg7wyrd0DP6gIWww
         RITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755620529; x=1756225329;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2PIjZ+DdmvuLwnrpTYlLbFeMpxoFxo/PTXBFZfTSGBg=;
        b=ZYJ006aGsRFsyrWRdgG/SY99e0UfkOYtdGRR/fI0LVl7xtV1RY/TtcJm7z+PhFkFl7
         xY7xq/Hnqsh2NR/e+IzG4K3fqFp143T2BlgRQ80cJ2iiykeVrVoJNefO6HDvEpkHz0ej
         VnMadfsKKd2sLiNkMvJ6RH9d/eszGWxBeSSJk+ZAZsSipXRN/F1eX46woo/5PUOVAgV4
         +zIrMBs0KFmJA6w/48dCEOwxCNX9tQer+3JNuTeYigUZ85R6pKV9yBtOBqH7zj1rz5fK
         jmkVppGQRAEiKENQLKExpbDfkqPH8PhEvyhPtx2J0e62YfKWkA/7pwwewzC1t1kwel0W
         yI5A==
X-Forwarded-Encrypted: i=1; AJvYcCUrKYJ7V8AnXC24XDfF2wdkPcp4nlVWTs48AQmFFQMR/ii5PZUMKycTgX3sj8ashiqzVnCJ+w==@lists.linux.dev, AJvYcCVJ4oxrUb8G2AxhT5xPsbPSJyVL6q2QjDAUQcQQrA9pYYtm8qeLtEXrtbySfoc00gmsJbqruRM=@lists.linux.dev
X-Gm-Message-State: AOJu0YzcA/RTksE1v4WABQbis1BUWRKYSu+Uv8haVIFueE1lm0EMFv7w
	13tTBOANC/YMmGEAhMlvO75yv0JkBIPxMvxtb4WAalPc+o/WoRux8C5W
X-Gm-Gg: ASbGncsXJDDD03v5FCMf7P/c34cKhzFKic+JZ54vqSptTlk9XYABTxVMy/wNKhS0vmQ
	SbiDbdrratUwAze5rcNwxuKNz0TsqTpaXSOxQuizSFawn04pr+UuNC/J6rvZSw7vy/ObWGNMdkF
	E+jbivWkL/7BOGEkq5wsjFsSU7oN3WGu/qkQtEeQK49L6yF5WEOpxDGa88f8FuL1qh4uGW8vetu
	JedGDTJOqSv3x1rcCGMfQvHDeBRDo2VKwWSs+scnlMOxQSujppRF2iLlF6PTy9J8opuHo7lv7/2
	4e87ykaUbvepaBMysUqj/e5Ic+1FgPG1kGHVCbq52uG4Tmh3oj90Hx9vrgYFmepmVGDi7bB9riJ
	SGEUZ7R+MJ+YGmMDsZ6pUmEm1hX8RIuVpwicivwUg+7UVIDTpwDDKgyEqhJwqUEE=
X-Google-Smtp-Source: AGHT+IE1/3he44rcwmPwhGdP/2lEsUGbA2b74tOIcgVsabuA/J7rKhxfaf9z31Cj2VPPRLhP8RZaew==
X-Received: by 2002:a17:903:3804:b0:244:55b5:7cfc with SMTP id d9443c01a7336-245e047bc13mr43207695ad.37.1755620528713;
        Tue, 19 Aug 2025 09:22:08 -0700 (PDT)
Received: from [192.168.0.124] (061092221177.ctinets.com. [61.92.221.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-245ed4cc807sm1323105ad.82.2025.08.19.09.22.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Aug 2025 09:22:08 -0700 (PDT)
Message-ID: <66ec7bd7-6b14-4766-97a1-3928d9129880@gmail.com>
Date: Wed, 20 Aug 2025 00:22:01 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/9] nvme: apple: Add Apple A11 support
To: Christoph Hellwig <hch@lst.de>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Alyssa Rosenzweig <alyssa@rosenzweig.io>, Neal Gompa <neal@gompa.dev>,
 Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Keith Busch <kbusch@kernel.org>,
 Jens Axboe <axboe@kernel.dk>, Sagi Grimberg <sagi@grimberg.me>,
 asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 iommu@lists.linux.dev, linux-nvme@lists.infradead.org
References: <20250818-t8015-nvme-v2-0-65648cd189e0@gmail.com>
 <20250818-t8015-nvme-v2-7-65648cd189e0@gmail.com>
 <20250819083038.GA1901@lst.de>
Content-Language: en-MW
From: Nick Chan <towinchenmi@gmail.com>
In-Reply-To: <20250819083038.GA1901@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 19/8/2025 16:30, Christoph Hellwig wrote:
> On Mon, Aug 18, 2025 at 04:43:00PM +0800, Nick Chan wrote:
>>  };
>>  
>> +struct apple_nvme_hw {
>> +	bool has_lsq_nvmmu;
>> +	u32 max_queue_depth;
>> +	void (*submit_cmd)(struct apple_nvme_queue *q, struct nvme_command *cmd);
> 
> Please stick to 80 character lines for the NVMe code.
> 
> Also I don't think an indirect call here is a good idea.  This is right
> in the command submission fast path.  A simple branch will be a lot
> faster.

Ack for both of these points will check the other codes that got more
indented as well.
> 
>> +
>> +	if (q->is_adminq)
>> +		memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
>> +	else
>> +		memcpy((void *)q->sqes + (tag << APPLE_NVME_IOSQES), cmd, sizeof(*cmd));
> 
> This could use a helper and / or comment to make the calculation
> more obvious.

This part of the code could be further simplified and after that
it is similar to nvme_sq_copy_cmd() in pci.c:

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index f3999b8ef7ab..ff4c2f87770c 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -295,20 +295,17 @@ static void apple_nvme_submit_cmd_t8015(struct apple_nvme_queue *q,
 				  struct nvme_command *cmd)
 {
 	struct apple_nvme *anv = queue_to_apple_nvme(q);
-	u32 tag;
 
 	spin_lock_irq(&anv->lock);
 
-	tag = q->sq_tail;
-	q->sq_tail += 1;
-
-	if (q->sq_tail == anv->hw->max_queue_depth)
-		q->sq_tail = 0;
-
 	if (q->is_adminq)
-		memcpy(&q->sqes[tag], cmd, sizeof(*cmd));
+		memcpy(&q->sqes[q->sq_tail], cmd, sizeof(*cmd));
 	else
-		memcpy((void *)q->sqes + (tag << APPLE_NVME_IOSQES), cmd, sizeof(*cmd));
+		memcpy((void *)q->sqes + (q->sq_tail << APPLE_NVME_IOSQES),
+			cmd, sizeof(*cmd));
+
+	if (++q->sq_tail == anv->hw->max_queue_depth)
+		q->sq_tail = 0;
 
 	writel(q->sq_tail, q->sq_db);
 	spin_unlock_irq(&anv->lock);

And this seems obvious enough on its own, and should not need comments.

> 
>> +	anv->hw = (const struct apple_nvme_hw *)of_device_get_match_data(&pdev->dev);
> 
> Do we even need this cast?

Don't think so, will remove.

Best regards,
Nick Chan

