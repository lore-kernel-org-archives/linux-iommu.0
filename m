Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47C920FE
	for <iommu@lists.linux.dev>; Fri, 20 Jan 2023 12:47:24 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 247845F9A3;
	Fri, 20 Jan 2023 12:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1674218837; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iW4bxpzyfiS1Xr0QYpWy5DrZdVyjcp1783y3lQmmDo=;
	b=yAKQQOYR6pt0roxMHDb3S+MmXAuhZMoYgOK0XOhbi6MLgomsD6UNHdG2eUh8GurpGqgyUj
	Mtxdy4MH8jHyk+cvvE27k1V4Q0jh2Q9/lnIXgkJjd5C/BqdahdWrvS/rBOv++2/28tUGiz
	EES8nnfhOmwfia5EwfZ5ertENgVdKJE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1674218837;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0iW4bxpzyfiS1Xr0QYpWy5DrZdVyjcp1783y3lQmmDo=;
	b=xsRcwalk8p6OwQXfqj+SepPKeMeXtbwlj9SWOz+6bmKdSqxZ37/akPKAOrD1KTKj4WmFgs
	i5Cio4O0kC6J00Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EA1821390C;
	Fri, 20 Jan 2023 12:47:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id 6vy/N1SNymN7JAAAMHmgww
	(envelope-from <jroedel@suse.de>); Fri, 20 Jan 2023 12:47:16 +0000
Date: Fri, 20 Jan 2023 13:47:15 +0100
From: Joerg Roedel <jroedel@suse.de>
To: Yang Yingliang <yangyingliang@huawei.com>
Cc: iommu@lists.linux.dev, linux-samsung-soc@vger.kernel.org,
	m.szyprowski@samsung.com, semen.protsenko@linaro.org
Subject: Re: [PATCH] iommu/exynos: fix error handling in exynos_iommu_init()
Message-ID: <Y8qNU6e4DbXVCC68@suse.de>
References: <20230104095702.2591122-1-yangyingliang@huawei.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230104095702.2591122-1-yangyingliang@huawei.com>

On Wed, Jan 04, 2023 at 05:57:02PM +0800, Yang Yingliang wrote:
>  drivers/iommu/exynos-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks.

-- 
Jörg Rödel
jroedel@suse.de

SUSE Software Solutions Germany GmbH
Frankenstraße 146
90461 Nürnberg
Germany

(HRB 36809, AG Nürnberg)
Geschäftsführer: Ivo Totev, Andrew Myers, Andrew McDonald, Boudien Moerman

