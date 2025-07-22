Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BF11537DA
	for <iommu@lists.linux.dev>; Tue, 22 Jul 2025 02:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753152079; cv=none; b=GYxP31z5TCR1wh83egbVrQ42YTJP23rw5ALtdX+vSru5o6V+vXmUhQGfYdb626YkP+WdCzKtwuZR0S8w+SwS0C0uHcS1IxfZGxHziq8O2ivCt2Tr1in42JqJOBHAOnS56xNnPD1yWrKOi4EzlP4c8t0+3IVjazuzA2ExF26OU48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753152079; c=relaxed/simple;
	bh=lj/3O/Co/a/TOZNtsKz34bzvrLC57/+nYzQmJf/IWe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JH3O2QsUOyyuQy0eJ2tEn9UrIv9dkFfweNSScjEhx1VBqHAKf7+sNDeMH+VTZzB19vSzIx9aRlK9VnHd+wQPvWkCujv6dP5/xIwj+tXjy3daOdlkLPLXOo0eA6O3OYy+FsdEC7vUL8F6yhG9f5ZiLgJxuTGdK6rlRbH1Ni+cse0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bbaa.fun; spf=none smtp.mailfrom=bbaa.fun; dkim=pass (1024-bit key) header.d=bbaa.fun header.i=@bbaa.fun header.b=BgeJLEWc; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bbaa.fun
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bbaa.fun
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bbaa.fun header.i=@bbaa.fun header.b="BgeJLEWc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bbaa.fun;
	s=goar2402; t=1753152041;
	bh=lj/3O/Co/a/TOZNtsKz34bzvrLC57/+nYzQmJf/IWe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=BgeJLEWcePu7iD/obLTmpu4rwdPb/JJDc047l9iEf8fKwujhBcyU3brnL9KRfiC1w
	 xkzbIM4r3RTsrFa81XdzLNa0GwezlT/RjfKVckV+mJU3JWGDalBI388d60i38UOi1R
	 bLv+X3hcGLNPM95H/izRg+nAReMYDGRXRlHkPa8U=
X-QQ-mid: esmtpgz11t1753152040tbfda5de9
X-QQ-Originating-IP: qGvRIJKo3JyH86pqieyk/fky0Wuzm4ofHUD0t81YHKg=
Received: from [198.18.0.1] ( [171.38.232.96])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 22 Jul 2025 10:40:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3727465619527990102
Message-ID: <A862457AA700FAA4+c9af0384-8fb6-47c9-9876-8ea8be528ac3@bbaa.fun>
Date: Tue, 22 Jul 2025 10:40:38 +0800
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: =?UTF-8?Q?Re=3A_=5BREGRESSION=5D=5BBISECTED=5D_PCI_Passthrough_/_SR?=
 =?UTF-8?Q?-IOV_Failure_on_Stable_Kernel_=E2=89=A5_v6=2E12=2E35?=
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, bbaa@bbaa.moe
References: <721D44AF820A4FEB+722679cb-2226-4287-8835-9251ad69a1ac@bbaa.fun>
 <6294f64a-d92d-4619-aef1-a142f5e8e4a5@linux.intel.com>
Content-Language: en-US
From: bbaa <bbaa@bbaa.fun>
In-Reply-To: <6294f64a-d92d-4619-aef1-a142f5e8e4a5@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bbaa.fun:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: OE2BWzPe+8GtWb6VslmUpZ2QttO/EHJ717EaT4R/QwJrteMgXvF2L9JO
	+BM280WoIVJtycwCm4iiTjKuuISpJp4ROQI6TDI7VwywNBW0rr+ER/P0ST1gg71X0LnhuSW
	+22SoUQmxq38hOHVEz1ilI9tTHTI6n5WwOpnuV1K9ZsMbqEXhaVoH4uyKWRpZJeDxyNEXNr
	BztBzU5r4Zz2cFTSMuMZXriNyfbTYF9R40CbgmMSySH7PbStT6+NjVyR+NFm7sv+86fvgHt
	KS/D0Y/00CqapeaBWKMcoMLX6go4csatcFpv3fZBwo14Df62APk4n2Ttd6HIbwzvEJUaSbf
	KWiC7hY1a+bGJhX/iymQjnxQzF/ztunrkDBDmojWldGytn7kkm7CAazO8PowJxT6WawAjM4
	kuwz5+FqSPw16JfAqFbGIGWypwP18AUpvxAjOvynVgjNOPM/mao5f5FzCNDCtiJGtUw1iNt
	PqVe8kZuqwyKsEmuOnfI/iaHxvp/TtpoAEsw0boCYWClKB1JM/3fVCoKMf2keezPixGpe+O
	g4dd4N59+fNEYy0u/uNno+XWM3vgPYA5rk701TPAhascHxQMfOn2VyuJyk6EdUBGJ8U/2bq
	8R5vBMsZZTHKWhJwjVZUuX/pgLMscN2gHVkUle8KfGvk8VKJzlFiPdMR9tuRyCMMC/RRgdy
	v5f31PDji8Tv8k2SxiXP/V8UBEKugZxY+/4kkZrgpV231RztHCpNDQD8hoQISwMHYhn8yeW
	TRCyHDgM1Pfx7WC1q8C7VF0zq4RxzI4Ash1pfYMWVjNS5zh6ayOOsFSwf4x1DCAx2ZA+mWH
	aA1kpwwG/SkSlPMGDL69xHCRu1Tg+EN/bnzVqyiEu1Ml38PeqxEZVUuxcVKwMgchOM0k2Fs
	kd5e9mE0iQvK/8xfVs0Aa3Z+xt07KyLlDPjNKSIPV5ZGtiltu7dwtbrRjYyXgsceeQA5rPp
	lpfV6KsxnPIhyJVcZjHSmngD5
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

> Thanks for reporting. Can this issue be reproduced with the latest
> mainline linux kernel? Can it work if you simply revert this commit?
>
> Thanks,
> baolu
Simply reverting this commit can resolve the issue.
Since Intel GPU SR-IOV currently depends on out-of-tree modules and is not yet compatible with the mainline kernel, I will test it later.
It can be confirmed that the v6.15 stable series is not affected, which also includes a backport of this commit.

regards,
Ban Zuoxiang




