Received: from smtp.smtpout.orange.fr (smtp-23.smtpout.orange.fr [80.12.242.23])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0D55262FF3
	for <iommu@lists.linux.dev>; Mon, 18 Aug 2025 06:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755500099; cv=none; b=Evz4jLhVP5cDSoDsVobsVmbaUwjUOZ/FQoMNz7aug+wGCnuqztAzo23SEZ770RNE+30T3e1Pp7Ie0kpRNNHB2oA/37sMQRjGBp9hBKsl1Ns14Nm4yQQpeyHAR+rmk4wQAKeD9M4wqpRDHbCZ8/FCdTKkBBXU02s1p7t8btans7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755500099; c=relaxed/simple;
	bh=PiRdQi2DNTOyWPjbp/n22ix0QwyXtFNXOR21zOCXrsM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YkB5bm4FfbGpqiU/XL8Lrs1lNuRqL99DTtp9xAde3I1Q3vO0aNSs+3//areWy28hEmZ7j8JwfH/pTLksexr32hKrSAF0pkED5z1JTkKIP5uxyqngwLHcVWZt34XLXjiZ9BDZYp2WpL9b/freuelplNNZ4If4DQ+0CcocvC7qsmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=SzMQDmWq; arc=none smtp.client-ip=80.12.242.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="SzMQDmWq"
Received: from [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
 ([IPv6:2a01:cb10:785:b00:8347:f260:7456:7662])
	by smtp.orange.fr with ESMTPA
	id ntkVuLsjrZ80pntkVuQAKL; Mon, 18 Aug 2025 08:53:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1755500025;
	bh=y1i4Ok6MNpfH7xDFQ14ItWKQD+IgHVNXWLSdzG0AENQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=SzMQDmWq1fMPidsfbky5r+WvlhNQxqXcXBUcrWn8deWX3BhFCI6r7xpGV0KMnxIo6
	 IMEJyjzzb3aP6fVaNdgltHtCAe5snaN7OOQoIl7leo8UE/Jzf371UtU/0QKbTRR2k0
	 Piv+KxtZAK3r6Nn3IcZPCX20q8AP6GNZkZqc2JGQZTk0w1W0Xgh8lqUCtTsgY6OEhk
	 2Oks+MJVRi9RaRY4oR+wvcnc73XHCng/QhoRiO889PiUv7rQJdzexF8eUiBvxHOsDq
	 ml7q8LYN+6oAYmbG/wG2pfQ6JvCFoK1tvU4Gwht7Ro53MIYHevsC+lFnELP2kCkLH3
	 GrfuRO4pYVtrQ==
X-ME-Helo: [IPV6:2a01:cb10:785:b00:8347:f260:7456:7662]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Mon, 18 Aug 2025 08:53:45 +0200
X-ME-IP: 2a01:cb10:785:b00:8347:f260:7456:7662
Message-ID: <37faa705-4ea0-4dc8-a0d4-c26acf743c6b@wanadoo.fr>
Date: Mon, 18 Aug 2025 08:53:42 +0200
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/amd: use str_plural() to simplify the code
To: Xichao Zhao <zhao.xichao@vivo.com>, joro@8bytes.org, will@kernel.org
Cc: suravee.suthikulpanit@amd.com, robin.murphy@arm.com,
 iommu@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20250818035331.393560-1-zhao.xichao@vivo.com>
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Content-Language: en-US, fr-FR
In-Reply-To: <20250818035331.393560-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 18/08/2025 à 05:53, Xichao Zhao a écrit :
> Use the string choice helper function str_plural() to simplify the code.
> 
> Signed-off-by: Xichao Zhao <zhao.xichao@vivo.com>

Hi,

> ---
>   drivers/iommu/amd/iommu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
> index eb348c63a8d0..b5c829f89544 100644
> --- a/drivers/iommu/amd/iommu.c
> +++ b/drivers/iommu/amd/iommu.c
> @@ -265,7 +265,7 @@ static inline int get_acpihid_device_id(struct device *dev,
>   		return -EINVAL;
>   	if (fw_bug)
>   		dev_err_once(dev, FW_BUG "No ACPI device matched UID, but %d device%s matched HID.\n",
> -			     hid_count, hid_count > 1 ? "s" : "");
> +			     hid_count,  str_plural(hid_count));

Nitpick: There is a double space after the comma.

>   	if (hid_count > 1)
>   		return -EINVAL;
>   	if (entry)

You should also include <linux/string_choices.h> I think.

CJ
