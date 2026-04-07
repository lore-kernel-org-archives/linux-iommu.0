Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256F83C0602
	for <iommu@lists.linux.dev>; Tue,  7 Apr 2026 15:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775575892; cv=none; b=DARwottbKnsdj+qILmkVUAJ1jWvTyEpTS7Vxii6VusMl8W/zo6KEYG/KoRHuX0u5xQz8w0wnHfH4l5rVHXhLKLTG2blQ5msnllDsVvwzj9gPPKDH5UeeGKpuni/lP5SxX7JIw+wI77CvrUvTysDkePq0KlTwgbD7J70OJ6+Kopk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775575892; c=relaxed/simple;
	bh=RQc8d8POo53za1btklrzd2j41bVBDu/kMc2J8CQXhJw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bELOuMHz25VVVos/t31geXu8TEJOjl1HARE4pYWhWkZD6DbdpgRs8dVsWT7sKK0oRRQ5l8oYV8bZg5eg6HWVz/HPkI7JRyEgQWe25rXEFNgGAuZlFFVhtUrsznTcaJLpMMEMjVKrjiTUcnaVL9XgqiZGAZem7rZTkqSGAz06XQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bnWFk5xj; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bnWFk5xj"
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-1270fc2bdf2so35531c88.0
        for <iommu@lists.linux.dev>; Tue, 07 Apr 2026 08:31:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775575881; x=1776180681; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5fjyrHqf2RDTN165o9RX7THJTFjmJJ5U4Jjhs69/SOU=;
        b=bnWFk5xjPNu4tieiBEQV10VfRgStXUzi1ZxPguK79vok0lXixZLFOvG+X8QGl9Ltmq
         s+qh757jRbrDvHD0UjUEn2J0D29JxIWNXEJSceX2DlcCHxDvgk/rzoG6xwzj9zvQc3g8
         nll+QbwougLAQBI+A/TVBiiU6OHkkuhp8HPGi2iIzSnB3fgZmneza3K+2l4RSwpH1m49
         Nrgu4PPG4Xd+p85wM0O3wR4nVHavSCt8omDM9hGKjd1XjmbwzxYIkvdrbY8uJs9secF3
         0VABD7QMdhrQXnXOKtiptLpTO7jZunW4jnpwKTkYSJS264L30EPJjufEDzEMv64+2o+K
         yj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775575881; x=1776180681;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5fjyrHqf2RDTN165o9RX7THJTFjmJJ5U4Jjhs69/SOU=;
        b=YNzGTSIseK2wW1iXSLeyN7NNVeMuIPyf1KBMsykB8rk8BDlE4z1wVVvOOIs2JrwsO7
         5jLw5mnsyNXNXwUoyJCY9iwOo7CRS3i4Typ7ZNqFt4QA7N984GeYs9z1c2T3B1lPgmCq
         Fnk1EQyEaD+qMOwJYjXi72T7kwtvF99BbZY1IezjZXJtFa8XP6lzWj9IUXdxwD6GUB3s
         F+iFFq9r/uxE3H4DKE7ntZsY+yQyeGRW5SXLlrYoU0D0T4zbR2b8gMBTWT6XLT1wkUgW
         pNiQaOuX56j5BuVQxrgXd+eI/xXmNFD1e2BVBq5eMxI0Dayk5wt3NZ1eF8lNtKmeSYPH
         33QA==
X-Forwarded-Encrypted: i=1; AJvYcCVMYvPnNZfG+NiBuwegDiLML9H+/n+r0gYgmrfR5Piik9vBMIUKSe8e4LpqN5eOjtoNh1rO8Q==@lists.linux.dev
X-Gm-Message-State: AOJu0YyTu1ExkiNlCvREssKIrTeZU5DDwvKZM4kIhNcvgJTmFKY9VcsE
	lG3+PMHrapCYXNrdtqPCbx3Zyc15SGNdY0+vMEgiDZbl2PivPPGPN98J1gFPg4K+fQ==
X-Gm-Gg: AeBDiesbk/JlxhIAjyx6cBTY63FEGnAG0gttDuBmsenMu8qLRlw+3fFMgHRKDSwAvGi
	GMiQrY3Y5DhNTB5leHx67PSC9m/3MOnvZ444z3I5QUSn1TxrlErRHCfLLJwzpaUOnc4++MjmX4/
	j3xpTm55ayGQEapmXwSkwa18DSXIYtq2riv/P2OfJO0hP3W4Bo3LG4zkXtu11fQjhqaHr2a/NmU
	B9fHoPE9zD3K5CaxK7f2fpFjxdq0XAurFqOLk4h6sZQ0diXKjTMSsT8KP+Cs4YbS5Y5RUZB1wo4
	aEAcfT5vJJM4aTCdSFcnXtq1FT+zEiz+XAIlm3X9UfllWpVbrSUVe1AYKVewqzlWeVQPbpfC3kM
	A09HUf1t1G6yNmLymgWjED9oKSvhxGDywVEQv9WGBgHervBA6/xq586ICZSX1x8lkziCYO8zfAD
	9/AFXAXO+HgUUC8ZAqrehQXMjQgMv8G9QYEMSLh+Vy2Y+xPLuT2+8KLTyuzw==
X-Received: by 2002:a05:7022:618b:b0:12a:8cf4:65d8 with SMTP id a92af1059eb24-12bfbc17168mr462147c88.14.1775575880307;
        Tue, 07 Apr 2026 08:31:20 -0700 (PDT)
Received: from google.com (174.188.87.34.bc.googleusercontent.com. [34.87.188.174])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2d1bf4447dasm2731746eec.21.2026.04.07.08.31.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 08:31:19 -0700 (PDT)
Date: Tue, 7 Apr 2026 15:31:14 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Lin Ruifeng <linruifeng4@huawei.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com, jroedel@suse.de,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu: Use dev_dbg for group handling code
Message-ID: <adUjQpF4okGX4n92@google.com>
References: <20260407130638.1920205-1-linruifeng4@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260407130638.1920205-1-linruifeng4@huawei.com>

On Tue, Apr 07, 2026 at 09:06:38PM +0800, Lin Ruifeng wrote:
> When devices are frequently registered/unregistered, there will be a large
> number of iommu group adding/remove messages, which will flood the dmesg buffer
> and flush out other logs. For iommu group handling messages, we can use dev_dbg
> to output logs only when needed.
> 
> Signed-off-by: Lin Ruifeng <linruifeng4@huawei.com>
> ---
>  drivers/iommu/iommu.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/iommu.c b/drivers/iommu/iommu.c
> index 50718ab810a4..18ceaba6cf0a 100644
> --- a/drivers/iommu/iommu.c
> +++ b/drivers/iommu/iommu.c
> @@ -1283,7 +1283,7 @@ static struct group_device *iommu_group_alloc_device(struct iommu_group *group,
>  
>  	trace_add_device_to_group(group->id, dev);
>  
> -	dev_info(dev, "Adding to iommu group %d\n", group->id);
> +	dev_dbg(dev, "Adding to iommu group %d\n", group->id);
>  
>  	return device;
>  
> @@ -1337,7 +1337,7 @@ void iommu_group_remove_device(struct device *dev)
>  	if (!group)
>  		return;
>  
> -	dev_info(dev, "Removing from iommu group %d\n", group->id);
> +	dev_dbg(dev, "Removing from iommu group %d\n", group->id);
>  
>  	__iommu_group_remove_device(dev);
>  }

I believe this was discussed roughly an year ago as well:

https://lore.kernel.org/linux-iommu/84cb9155-4793-45f9-bb67-6926e103dc84@arm.com/

And 5 years ago as well:

https://lore.kernel.org/linux-iommu/20200302154426.GC6540@8bytes.org/

The general consensus is that the maintainers and the community would
like to keep this log in place as it helps us debug issues just based on
dmesg logs shared over an email.

I understand that losing dmesg logs in such situations could be
frustrating but I guess you could try increasing the log buffer size..

Thanks,
Praan
