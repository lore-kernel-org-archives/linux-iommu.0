Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881331B7F4
	for <iommu@lists.linux.dev>; Thu, 19 Mar 2026 00:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773878892; cv=none; b=VJrYMF0xykBokopOcQzMYx7mvUikanfhBRbSVHHaXv2x2dEYeBfnxoYzQYV1vuQ+2YuUFU9lmm6aluXVuVeO6U1MJCF9zxewr09qQO+mHgBpnzVIMmKK6CTgbPw8oEJwFsIEl9RGtgp6GxX44nha25OXHTdjUWQJMcKTSED97OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773878892; c=relaxed/simple;
	bh=9Lna6RLq1PceWhp4JFSVoi2qGNT1NzgxgPC7c15ur54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bjE7EataOIVqLX7TOql3vZeZIShLqlaoEw/tqDjnmQGT/amIUNlMvBPCP1BnJItN3dX0Z2wMgQcY+ylv9CdgV7CnumyQxt/W736J+AksyJTKoXV7rya6VCaswLyIonXtAtjEncUVytlV9ikao+Rq8yJDEeWBS0eT1sP137ojN3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mwkgTMjB; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mwkgTMjB"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b052562254so37345ad.0
        for <iommu@lists.linux.dev>; Wed, 18 Mar 2026 17:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773878890; x=1774483690; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AY/dmLi/z8SUAAMZ2gqdSfQxfr35ot2Vi6eYrVHNvEQ=;
        b=mwkgTMjBxlDiFB22EWIqde8sDlZiwyNdQLuB9Id5aOAuGObRPo4IZsJVLfN9FzZlFO
         w8eG5hP/Kqducq1+1e53UybCZT76dy8o4oYp+K1i2UFySeH3vK08mgzj05mMVemVXQ7n
         9txNv7fIMfzo5g9LppxUdIJ4G7HWnHYnVvHKfg6ZdOI4t7HJ01ub+NlQ1oh85Glxm840
         /M1UhLyVbl03g9NLQ3UWOFhduqQqyLz8HkY5wNZHjYGVUlFs0N7Ydk8t5AVoCExEFxij
         8NagVwIxsmhwmRz+kT4WkRhpiufVdQbEYxRqVOJL3F8Jr5wtE/YgoH9MPxryQUBgsfqv
         0Wvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773878890; x=1774483690;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AY/dmLi/z8SUAAMZ2gqdSfQxfr35ot2Vi6eYrVHNvEQ=;
        b=Tw1c1pH0dz0RI7jtyvxfnI8t4qngqHmCI0XcE6Ed7SJr3wuTbuGlvuP9XbGSR6vYQp
         w0ev2gDNZuK65m6lMYptS/eCUDapX7nKf5U2WgXFBqAaKo/UjIaXwZCLyJGaM5SEb6AB
         2Yo4TMAHYeqbKtmfx/f0kXlE2usl0L5024/b2Cx8Nj9kDeQqnUjH7vw4bbWPLlVZYdDj
         QuitbyRyCBpfY336SA/buiSJicsmYlhT6hldvIjJe1TrmvAwVZY7JKLsud6h/i0Y5F6R
         NC6+agv8AyJLhaCnuK2tCE1mG/OSI4c4iQMe4hdrgKRH/fVcmqknDce+22+HgbCSX74d
         Y5Og==
X-Forwarded-Encrypted: i=1; AJvYcCXNz9J21T4BFsfSnK0CKsmSB0KiHs/SlP57IsNvSfF/qRyVOTC1mKPJ1pGOyo7t1e80ZvxblA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzBo3I/Lb1JkNOZ0rbJ2HIM8Rzub3nEalppOdLcSfIEK/flfXrf
	eRAhSZYX1p7WNk6olraEov55zJj53XFe+Q/R1g4FySKV8VpYiqqR9Ng/wDWgZ0HIFQ==
X-Gm-Gg: ATEYQzzvqcG6Hg/jQaS27kvKOI6y9yU9Uyvx3JyrFQ9VI8YeURTFwKzZKfhKvPr2lQM
	IfzhsqfMYfTl+2697VbyJN0txau2odmqCh2BGMhPDuCkah5Jfd4RYxVon9ODGhokbTTYy+y2f82
	Xh65mb5mD1Yj55BveLT4XYDU3hE93CAjPSZmnwxFeI6uqAXy5/SdBOjHzRbMydKCIAju8v8oDFR
	stg/tAxky1AIs1Q2G+d2oNG9gxsgi8g9lEJnjgIt2Uy/GFVIBOWXniA7j4fFVIH7xxGPck/P1LP
	j/1aAEyvk5bml8CIGn75lYUvb70WX0Cd/vxM3uDXkSICThZYEG483Pa+H4OOhl+UYGZBzazWSQd
	+ss+UKlNW0fopWlge5VA6ByrkrJq7t4s9Ytw3MT7wRs7rn8BgWJMhHtOUwi3gB2owK+CVdiufZ1
	MhPv9GbHC/lw/X1mrNOUGRf/ja7T7FTkFofAH6qg/zk26aWehOVLuqFWB8r37ucg==
X-Received: by 2002:a17:903:2ac7:b0:2ae:45cc:aeb6 with SMTP id d9443c01a7336-2b077b4ca86mr1596195ad.6.1773878889199;
        Wed, 18 Mar 2026 17:08:09 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbe6162sm3741880b3a.42.2026.03.18.17.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 17:08:08 -0700 (PDT)
Date: Thu, 19 Mar 2026 00:08:04 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: will@kernel.org, robin.murphy@arm.com, joro@8bytes.org, 
	bhelgaas@google.com, jgg@nvidia.com, rafael@kernel.org, lenb@kernel.org, 
	praan@google.com, baolu.lu@linux.intel.com, xueshuai@linux.alibaba.com, 
	kevin.tian@intel.com, linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org, 
	vsethi@nvidia.com
Subject: Re: [PATCH v2 4/7] iommu/arm-smmu-v3: Mark ATC invalidate timeouts
 via lockless bitmap
Message-ID: <abs6PudCAh-eVRPA@google.com>
References: <cover.1773774441.git.nicolinc@nvidia.com>
 <0c5525367cc67ccc84a675544d1d9f8462704065.1773774441.git.nicolinc@nvidia.com>
 <absfAT4jgL2f3UfR@google.com>
 <abs0CQCrFlCsV6Ls@Asurada-Nvidia>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <abs0CQCrFlCsV6Ls@Asurada-Nvidia>

On Wed, Mar 18, 2026 at 04:23:53PM -0700, Nicolin Chen wrote:
>Hi Sami,
>
>On Wed, Mar 18, 2026 at 10:02:32PM +0000, Samiullah Khawaja wrote:
>> On Tue, Mar 17, 2026 at 12:15:37PM -0700, Nicolin Chen wrote:
>> > @@ -895,9 +898,19 @@ int arm_smmu_cmdq_issue_cmdlist(struct arm_smmu_device *smmu,
>> >
>> > 	/* 5. If we are inserting a CMD_SYNC, we must wait for it to complete */
>> > 	if (sync) {
>> > +		u32 sync_prod;
>> > +
>> > 		llq.prod = queue_inc_prod_n(&llq, n);
>> > +		sync_prod = llq.prod;
>> > +
>> > 		ret = arm_smmu_cmdq_poll_until_sync(smmu, cmdq, &llq);
>> > -		if (ret) {
>> > +		if (test_and_clear_bit(Q_IDX(&llq, sync_prod),
>> > +				       cmdq->atc_sync_timeouts)) {
>>
>> This will not be set if a software timeout (1 second) occurs. Do you
>> know if the ATC timeout of Arm sMMUv3 is less than the software timeout
>> in the driver?
>
>You brought up a good point!
>
>I think ATC timeout follows the PCI Completion Timeout Value in
>"Device Control 2 Register", which is typically set [50us, 50ms]
>but can be set up to [17s, 64s] according to PCI Base spec.

Agreed.
>
>> If not maybe we can handle the software timeout here also as the cmdlist
>> is already known?
>
>I think it's trickier.
>
>If the software times out first at 1s, it means the CMDQ is still
>pending on wait for the completion of ATC invalidation. Then, the
>caller sees -ETIMEOUT and tries to bisect the ATC batch or update
>the STE directly, either of which involves CMDQ. But CMDQ has not
>recovered yet.
>
>Then, in case of a batch, all the reties could timeout again. So,
>it will fail to identify which device is truly broken. This would
>end badly by blindly disabling all the devices in the batch. Also
>the disabling calls require CMDQ too, so they might fail as well.

Yes, looking at VT-d currently and the queue length is 256 and this
spirals out of control quickly.
>
>Thus, partially to answer the question, in case software timeout,
>I am afraid that we can hardly do anything.. :-/

Agreed.

Do you think we can maybe document this somewhere? Maybe add to the
cover letter?
>
>This means I need to set a different return code for ATC timeouts
>v.s. software timeouts.
>
>Also, there is another problem: when PCI CTO finally reaches, the
>GERROR ISR will set atc_sync_timeouts but nobody will clear it..
>So, before calling arm_smmu_cmdq_issue_cmdlist(), we need to make
>sure there is no dirty bit on the bitmap too.

Yes, Just to confirm, do you think this needs to be handled regardless
whether we handle the software timeout for the ATC invalidation?
Basically to cleanup the bit on bitmap.
>
>Thanks!
>Nicolin
