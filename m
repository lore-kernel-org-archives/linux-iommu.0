Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FC01ADC4
	for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 20:17:48 +0000 (UTC)
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2bb97f2c99cso3138441fa.0
        for <iommu@lists.linux.dev>; Thu, 17 Aug 2023 13:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692303466; x=1692908266;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Ff2AaOO5GVflY+bf7LJFqgwCYhGi1upYqHWzZWCwCTM=;
        b=GxzVe33CxHSnsQVg4vV2CCTPd1mvSZO4ZCi3mLu8FGoWFuv+jIMDlGGoCsiyGFr7IK
         trc3ozLRH8FRulcAq41lTULdQncXtMHTA3fnPJhNB6rk3ohXv1PJG4nVaYNjjyDuu2WI
         CApb7vDd8tD+bfaUaGO3uszeTfqWRfYTOhdGr2/rFKVZssiUJf+gqLGmWvYI5vlLUV1Q
         D17UCiNNwUt2JQl4fB8sIjEec5AalEdTvO+VXb0c7f7LZOlTutCcjvOab73i6hT5Rni+
         32YlV6DQPZjMBJe4yByqao3vgdT36EWVSZC2Pu7fz7s1gYUydYvNektgAFTYQT5Db0Rr
         bbPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692303466; x=1692908266;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ff2AaOO5GVflY+bf7LJFqgwCYhGi1upYqHWzZWCwCTM=;
        b=KHL7C8Qy0OWLJmHM6U2n5I0p3I3/CgQm5FRh+K0JpXpgGMuk0Ci2f2UhbeAuJvBVkQ
         f4EFvrbipDRt56DesthnSmoINjhhIA2Ta35v8b/hWPE4VjTZLhdMolRscFMLK0nIr0jc
         DU3gj8LOoBbfvkwmPg8+5cYl+9lHWP7ilOwZ62N2ncOHrmlwudQ0N6FZh2ReTz/YoY8Z
         d029RR6gt0oC61sYv1axJqFyA6jdHRisA1lGp8TWsKuY6UKvu95enGeNB8njWftwb0vs
         Y7zs8J854yuKK0NLeRXpKHaj70t6QK+Un/WUn9HtPtfQARPmnSFTm4w+D98pcTx6mi6C
         Qp6Q==
X-Gm-Message-State: AOJu0YzmiB0ZXfryeFDwC9Q8yYXHQ9JyYe16dHiaMnKdQ8etzzNVDsy+
	HDfyFIDewcxMaqQH+ATTpArnxx3uhUdGeAIj77JBMO8gsc7I5Q==
X-Google-Smtp-Source: AGHT+IHuV8DEy9Go/Mr8ROdxcp09NjL6wjbafqEfK7pVV/EOGjz3B2p6UIEtfDGGHqiJxYmmTObUG7yaTavoeeQ+Wws=
X-Received: by 2002:a2e:8457:0:b0:2b6:cf0f:1fbf with SMTP id
 u23-20020a2e8457000000b002b6cf0f1fbfmr294223ljh.42.1692303465808; Thu, 17 Aug
 2023 13:17:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
From: Chathura Rajapaksha <chathura.abeyrathne.lk@gmail.com>
Date: Thu, 17 Aug 2023 16:17:34 -0400
Message-ID: <CAD7mqrygN8W59SmeS2nEVppNVeoW3FsiVtOG_PH7fcV4C16YEg@mail.gmail.com>
Subject: Software bounce buffers Vs allocating DMA buffers in page granularity
To: iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hi All,

I have a question regarding the IOMMU software bounce buffer feature.
I understand that this feature was introduced as a mitigation to
sub-page vulnerabilities (which were shown to be exploitable by
Thunderclap).

My question is:
Can allocating DMA buffers in page granularity (multiples of 4KB pages)
be a feasible alternative solution to software bounce buffers?

I am trying to understand the challenges and performance impact of
such a solution (compared to SW bounce buffers) if someone were to
proposed it.
In other words, I am trying to find the reasons why SW bounce buffers
were introduced rather than allocating DMA buffers in page granularity.

Thanks in advance.
Regards,
Chathura
