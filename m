Received: from mail-dl2-f43.google.com (mail-dl2-f43.google.com [74.125.229.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B1938D406
	for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 22:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790290538; cv=none; b=Bd0q0VEFUOUmmxXhQ8v+QdUnj/Q4vaZ0s8BwkNg+XCeWk2x4uJtFL1tsIT0kpJ3CQw7xmKFeQcqdwnaFjfluN+6oa0WUqjLucLYo4L6sMtmVwwojwmCxKV/U4Qzx1egtyfmnUNuwLusPU0uMEx/I551HQYC4Mzrqk391OCe+0q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790290538; c=relaxed/simple;
	bh=Ot0cDlosSJ7B0rKy6gYVAmZetDbxU6jeRs6fzTiE2ZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRd+EU6DnHSGcAuDSS+sXZCZShYpRzndw9ITQOLRFKDNPcF02tZgMmZ+OhJV8S7yv9gpZryTvRMyFY0Cz5iXxBqKSjX/uHLxflfsR9nNYv1wga0IeXO+wJnAAM+a3btyyPVAEQAc940Zd1oG4N1OmsajYUeVViIxMbWDpbhI6zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=ilxzfZLK; arc=none smtp.client-ip=74.125.229.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="ilxzfZLK"
Received: by mail-dl2-f43.google.com with SMTP id a92af1059eb24-1438f55921fso126439c88.1
        for <iommu@lists.linux.dev>; Thu, 24 Sep 2026 15:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1790290536; x=1790895336; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tIp+aiyQTzTnGdKMDtuefZl/ywWVdEoeMd4a05iequo=;
        b=ilxzfZLKAWY6oUVx8j5rIedXjY3oOtX1Pjo9jnC10cWLCO21VIjcj5wHylaEzE5ZpV
         lxB1u1V6p4S0S5rR9gjLz6jl0RjDMjHLUWRNxk5nR3SoSuXMSZTQFUTrOMcifaS0+ImI
         62h6jzSfaJLxG69bTbfZI0UpOLITrx1tHjMb3IB4IRAnYOntEmMtMsllPsWzKMVMjeiZ
         x/cbNmNeWYcSl9dWGq9K1MmpmCEtAEdEIfCOhDJZqDJjFOPiSUyHhDlwIjPY7lquBLgU
         QGbgOyHAkUpAT/3h2y++AbtcYLiU93CU9+wfuLCPvTBpfSZYExCDpa9+8bYI1JOnmXjn
         qnwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790290536; x=1790895336;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tIp+aiyQTzTnGdKMDtuefZl/ywWVdEoeMd4a05iequo=;
        b=JEIciiyawzLC7ij+ugvd78Y7SUoCE7WmkxVrcMt38kHbUxWjadc4gPIOOeIPQH5Yna
         ce1QMpNQus+JhxYpMiDup60LSUBP7c4lS6liAbLORzlElWzh7DD5E2m5wFvPaduz/xvr
         QWDur59iAB554azAZ8NiDGFWS5J3RNPr+IXTLLzay9001XAHKpPvL9QXtj/23j7nThOO
         G6Dqet7vx50eXfaET0y6fh27rTO+lIoWAFB1pklYTwDMlMqFgJi+1hSKcYslSFu/dh0H
         Y1yXuLtOukLX1/t+3m93staklE7lCCc3DG0ltLM4tv+wMPKSu36YLO8ZoGzX99FiTgok
         Etfw==
X-Forwarded-Encrypted: i=1; AKwUvBwP6/Mny7kxajyDLAeGWWGZaFxredFfa/GVoUV7f9p6v42aToMjmLUj//ECLG1cTcAsbDl0Yg==@lists.linux.dev
X-Gm-Message-State: AFuF++nRfOZCMze4dDkVuk73jnDnx23Se7Wb9munT3JGiyyz3uYPi8rv
	mp1OVRhZroq7kb1YjO3bFA53OCQEvir4Cq6J4KZfS9AWQnex6FOhkYTuRhPXmq8zoJs=
X-Gm-Gg: AYBFou2FMuq4oF6rvO5xSRrEMbpbu5XRuYJwlOq8pzQTuoqaazkGvZV4RGA7EPP/k98
	EZ2QFUUYFX5UcKn1UhUFPYe59uGKgXyXj23aaHVYwgmDwqFiJvy348/StBgwDSxEjlVR9W7SjT4
	/Sv4k03CnFShMZ31d43U8XJ1JfNPQWXU0Ay7UEhHbyZDCO6Lxgsd+5zPYVbgV1JIwXiMceFFM/4
	4KGSliSswZbLbPxVo0ihPo7JuNTvjqevCMW7xxswYnNuOX1nrmc46MY1XDKfFulu+ND3DPGvizP
	2cGE9ki1nG/kOpVWVDuhqXjxNYQqIKp5qKYF7kCz5GqeCtMcxwkE5dZXoZTWVL3apvGpIQaTi5J
	SApuzY7ZVLZG4aR09Fs92MTmal2Fe1aBihhVdw9ftOR66MJwsT8U8ttHZz8UmSL0EBZ31qcNk98
	E1+pj6COMDWNveZlRQgGwFP+TiiA2GF40/ClffD7RIKxXb
X-Received: by 2002:a05:7300:7312:b0:33b:dd45:716c with SMTP id 5a478bee46e88-340cc11f887mr2763537eec.13.1790290535581;
        Thu, 24 Sep 2026 15:55:35 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34141d2fe4bsm1639551eec.4.2026.09.24.15.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 15:55:35 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1x9sLm-00000000elU-0EsA;
	Thu, 24 Sep 2026 19:55:34 -0300
Date: Thu, 24 Sep 2026 19:55:34 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Mentz <danielmentz@google.com>
Cc: Vijayanand Jitta <vijayanand.jitta@oss.qualcomm.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	"Joerg Roedel (AMD)" <joro@8bytes.org>,
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
	Prakash Gupta <prakash.gupta@oss.qualcomm.com>
Subject: Re: [PATCH v5] iommu/io-pgtable-arm: Add support for contiguous hint
 bit
Message-ID: <20260924225534.GD16465@ziepe.ca>
References: <20260921-iommu_contig_hint-v5-1-e7fbd1c3774d@oss.qualcomm.com>
 <CAE2F3rAMAnV9+WNLZtGQX6cHPsZ6wbfRJ1Z3d5mF1+8WHL-uMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE2F3rAMAnV9+WNLZtGQX6cHPsZ6wbfRJ1Z3d5mF1+8WHL-uMA@mail.gmail.com>

On Thu, Sep 24, 2026 at 01:36:12PM -0700, Daniel Mentz wrote:

> Interaction with Hardware Dirty Tracking (IO_PGTABLE_QUIRK_ARM_HD)
> 
> When Hardware Dirty Tracking (ARM_LPAE_PTE_DBM) is enabled on Stage-1 tables:
>  * In visit_dirty() / arm_lpae_read_and_clear_dirty(), dirty bits are
> queried and cleared on a page-by-page granularity
> (iopte_set_writeable_clean(ptep)).
>  * If a single 4KB page within a 64KB CONT group is marked clean while
> neighboring pages remain marked dirty/writeable, the descriptors in
> that group will differ in access permissions (AP[2]).
>  * According to Arm ARM D8.3.1, all descriptors in a contiguous block
> must share identical permissions and attributes. If dirty tracking is
> active on a domain, consider whether IO_PGTABLE_QUIRK_ARM_NO_CONT_HINT
> should be set or whether CONT sizes should be suppressed when
> IO_PGTABLE_QUIRK_ARM_HD is active.

This is right, handling dirty and CONT together is a PITA. You should
probably make them exclusive for this simplified implementation.

SMMUv3 is the only user of dirty and it will switch to iommupt which
does all this right.

Jason
