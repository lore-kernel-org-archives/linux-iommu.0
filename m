Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.39.247.168
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407585;
	b=Cu/LbCDfKcVQzZ4w8tNQl1JijBtZL84AX2mElzBVWVvH5l2PPipaWn+0a1gr0kcVNt1/
	 rZcckBWgfMvA5wVGpW5yz0CLBGusoCD+dOmqPFOx/5DTdcsBKS+zu1d3nAjbZa5skT4GP
	 9OvZBLuofXLftBYkXmRESFzXpehcFilDc5io/hQcmpObTDQCB6t/iBkEYYBjiMVlx3OOS
	 +RAXsgKwReGvnm3HZpRZLHn8ZRQ0SwdQw49suwukjmx/qiLRsh7WTggYg8TK5Hgtp70/b
	 LJjX6y5S8eyr/fGT+rsO66KM+w6uEGOPDcYi4mtBdCispRDr/Tvm1WVlfM8HC0MSJBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407585;
	h=DMARC-Filter:Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding;
	bh=Q7nTbtg3NOHUNDWE397ThEwNuYuuiTDqnX6yT9Vqs8E=;
	b=rMMFty+vmhxUzNiYFAQaq9l1a1/z/XRcODLI17ROmlEyY75A1Yq7TfU9a9whM/0rPVKq
	 soPd5lS7Ny2/Uemf1cwyZtINWpHkk29W8E6HCsWDoi0nQ9awtnOce7zCkEMWX4Qyif/Dz
	 tCbhU/xm3x/MomfWgHi/OvoVSThJRpWgPbZUY6ksclU9edbdL8DiL1W6tPymhRlCRH/FU
	 0J8HQ12C4/NbUQ4R8rGs9LLfIPI+j+YBcwyaGH7ZboLyr7rQu/SJbvjdVocOq/9zYcx7v
	 5yt13CKURnCfwpgf/D1JQtBww3hWmY47lvQ73gbwAkUjfnlkxnZZJzTZ7Z90sX2sYlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cyberchaos.dev;
	spf=pass smtp.mailfrom=cyberchaos.dev;
	dkim=pass header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=fQ7Jo0y6;
	arc=none smtp.remote-ip=195.39.247.168
Received: from mail.cyberchaos.dev (mail.cyberchaos.dev [195.39.247.168])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C10E260A260F;
	Wed, 11 Nov 2026 14:33:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C10E260A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyberchaos.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cyberchaos.dev header.i=@cyberchaos.dev header.a=rsa-sha256 header.s=mail header.b=fQ7Jo0y6
Message-ID: <fb7b4ede-a325-4c5e-a37d-fe3cc7a92f87@cyberchaos.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cyberchaos.dev;
	s=mail; t=1794407575;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q7nTbtg3NOHUNDWE397ThEwNuYuuiTDqnX6yT9Vqs8E=;
	b=fQ7Jo0y6y1TRDYwtYJgO1STJDXTDFtL/3trxMkZ0Ta6gVXwNHfIfQ/Ezhct73kXpoVFQWr
	4m7n74TvisUz6uatQ6SYNsbV4EeQw0ifL4ObQhnQ/uKYDaJehRR+ahM1hiEeja9VNgFDeS
	MpCJ+MZO13xY97WzfIP+bYOcF/+1tLQ=
Date: Wed, 11 Nov 2026 15:32:51 +0100
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Subject: Re: [PATCH 03/15] dt-bindings: nvme: apple: Add apple,t8142-nvme-ans2
 compatible
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Yureka Lilian <yureka@cyberchaos.dev>
Cc: Sven Peter <sven@kernel.org>, Janne Grunau <j@jannau.net>,
 Neal Gompa <neal@gompa.dev>, Jassi Brar <jassisinghbrar@gmail.com>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Hector Martin <marcan@marcan.st>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, asahi@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, iommu@lists.linux.dev
References: <20261106-apple-dts-m4-m5-nvme-v1-0-22f4827b4ece@cyberchaos.dev>
 <20261106-apple-dts-m4-m5-nvme-v1-3-22f4827b4ece@cyberchaos.dev>
 <20261111-comical-quaint-turaco-e8c1c2@quoll>
Content-Language: en-US
From: Yureka <yureka@cyberchaos.dev>
In-Reply-To: <20261111-comical-quaint-turaco-e8c1c2@quoll>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/11/26 13:46, Krzysztof Kozlowski wrote:
> On Fri, Nov 06, 2026 at 10:04:12PM +0100, Yureka Lilian wrote:
>> "apple,t8142-nvme-ans2" on the Apple M5 SoC is compatible with
>> "apple,t8132-nvme-ans2" so add its per-SoC compatible.
>>
>> Signed-off-by: Yureka Lilian <yureka@cyberchaos.dev>
>> ---
>>   Documentation/devicetree/bindings/nvme/apple,nvme-ans.yaml | 1 +
>>   1 file changed, 1 insertion(+)
>>
> Squash all nvmem patches. Don't add compatibles one by one.
>
> Best regards,
> Krzysztof


Hello Krzysztof,


(replying to all three of your emails here)

thanks for your feedback! I did run `b4 prep --check` and `make 
dtbs_check` before sending and it passed without warnings on all 15 
patches of this series. I will now also run `checkpatch.pl --strict` as 
you suggested.

For v2, I will make one commit per type of dt-binding, so "dt-bindings: 
nvme: apple: Add t6040,t8140,t8142", and then "mailbox: apple,mailbox: 
Add t8132,t6040,t8140,t8142", etc., ok or do you have another suggested 
grouping?

 > Please stop inflating this. You are only making it difficult to 
review your work.

It would be appreciated if you can tell me clearly what is expected, as 
this statement is not actually telling me what is inflated / wrong.

Thank you!

