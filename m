Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 695D0AD2E
	for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 11:22:43 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id d75a77b69052e-40631c5b9e9so203801cf.1
        for <iommu@lists.linux.dev>; Thu, 27 Jul 2023 04:22:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1690456962; x=1691061762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5znSXkBTI7s/miWUhZa06rDZhJ/+eYLN2IwckbqVcpM=;
        b=CDP/mJ6pIwwNwaMUbOAIFOQXZTexa2gF8bh/6x2AhR9HwVUFpBynA6umqzTsEQTGTI
         NDXybLHyUBaZYGBIU0Hxxw+KJUtSWoLn60tOa+yeqtwlD6vF0j8pCNYzTgJzb41ronjf
         DOOay1BU4I6aohcInADy2DOd0rZjv1VVhdisnyLZfCww/zv7EEeU7oxY0mnl6kXQsLNH
         HW1jE63zHWd/8h2ZlyCNDGMelrHhqBRneaWrb28ENECnlFfAEMsFOGe7sdRUvSDEZ2Ns
         8GKR+H+TtxdIcuhF18kB8OAEvDMA9leyjBLYO8XIgbqFR8m8IMQ5ICaxeTB5Zg5Emzcp
         HS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690456962; x=1691061762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5znSXkBTI7s/miWUhZa06rDZhJ/+eYLN2IwckbqVcpM=;
        b=DaY/OQpjwS4UbLf9bYRM6aGVSrSI0tJJthAAhMZp/unhsN6sgmMolAizZ9leonajjQ
         zZZLg4UbZGZUhd8IEVjTXroRdKziOYMz00KxnP4jzPLIxBmJjyh34nCNi5FHOsrnV+lX
         VE4L7Fc2ZGmYInTyw1eHXzrSMFMERPOYABdvl89xfj980cko0evr3KTxx1KV1zJpYUwQ
         GL17MX09zdObOCC0xqeYWY2fVr+vfEovwAS5XgCVdteJ+HXBpG6hqMkKy7+zE6q/h4q8
         e4+GK8WPIezLctR5R0XO57XyEP4iN+gHzSLW1oXSGYMhnwso0Kz8QcTMBUvg2fe5X3UX
         jjiA==
X-Gm-Message-State: ABy/qLZCjh0BJFZ4eAfMKCXwakPMZ70dAEUZtSdLHwI7KaAyBg8rgn27
	8U/UwlsEg0nLoibQYMHmuultPD3cwUBuZ1r31YsXOg==
X-Google-Smtp-Source: APBJJlFKsrhjqr+pGO2xPAA7ZPtIkomN091N3COEvvJv97fo1FfhsvUjkQ1Uim0YUmvbb045Wes5qVyQXhvsWl+gViw=
X-Received: by 2002:ac8:578d:0:b0:405:432b:9973 with SMTP id
 v13-20020ac8578d000000b00405432b9973mr220819qta.0.1690456962027; Thu, 27 Jul
 2023 04:22:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20230621063825.268890-1-mshavit@google.com> <20230621063825.268890-3-mshavit@google.com>
 <ZK9RycgNAVrxe343@Asurada-Nvidia> <CAKHBV26wi+xKnNjo-R+QOcVLPH2KJTFP+mF4CW1xE61nOdF5GA@mail.gmail.com>
 <ZLAKQw+DzcpSRSyi@nvidia.com> <CAKHBV25YadRVFiag5z5Yc13L093ScWkCjAOCd=VuGm2RUaDyzA@mail.gmail.com>
 <ZLApQjaqoOshT2TJ@nvidia.com> <CAKHBV25BRWTxXO0YTGq3q1OdMQHAzop8BqJJaa9CHxdQzxnNbg@mail.gmail.com>
 <ZLFLyh1b+wiqb7Ql@nvidia.com> <CAKHBV24zQ+4waZgsYV08LzeMkjze1gTcwvEv5uL8RM1GcBgrzg@mail.gmail.com>
 <ZLU0IZJr6WSjknHf@nvidia.com> <CAKHBV25QZn9xApRT+=oAtwQRAjCD--S46uXRDwW+E5=at0ESQQ@mail.gmail.com>
In-Reply-To: <CAKHBV25QZn9xApRT+=oAtwQRAjCD--S46uXRDwW+E5=at0ESQQ@mail.gmail.com>
From: Michael Shavit <mshavit@google.com>
Date: Thu, 27 Jul 2023 19:22:05 +0800
Message-ID: <CAKHBV26sRpFJv8-_f4n2jsTKiOgnHF0_FZ07KBbVaueX+T2kWA@mail.gmail.com>
Subject: Re: [PATCH v4 02/13] iommu/arm-smmu-v3: Add smmu_s1_cfg to smmu_master
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Will Deacon <will@kernel.org>, 
	Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, jean-philippe@linaro.org, 
	baolu.lu@linux.intel.com, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Sorry for the delay; I'm trying to refactor these patches now.

> I think the master should have a pointer to the iommu_domain that owns
> the STE or if NULL the master should assign its internal CD table to
> the STE.
Just to clarify, does the nested domain patch series require writing
CDs into the user-space's CD table using arm_smmu_write_ctx_desc()? Or
is there any other requirement for writing a CD into a domain-owned CD
table from arm_smmu_write_ctx_desc?


Writing a CD entry to the CD table involves some dependencies on the
master(s) that the table is attached to:

1. The CD entries STALL bit value in arm_smmu_write_ctx_desc depends
on the master (e.g. if STALL_FORCE is set on the smmu device). This
could potentially be encoded in arm_smmu_ctx_desc_cfg, at which point
that CD table is only attachable to masters with the same
stall_enabled value.
2. arm_smmu_write_ctx_desc must sync the CD for the attached master(s)
in the middle of writing CD entry.

This is all easier to handle in arm_smmu_write_ctx_desc if the table
is always owned by the master.
