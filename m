Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CD4181323
	for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 17:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499991; cv=none; b=rdf9VCyLtWXZO9JDy6cIZtXwTSRtb/Bn9B6G9idH5S1CyGjK/b5/KXOrytZJP1rLlcZL4pqx9/Y0ZWEJZL8favatauGfztfn3i1B2Ktj1cE+xHDnKWrT0tCnUp6Zv+Jk0AOGBXxhMfnePnhNCV6tZycpjk6vdP7Am2lpMaO+jFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499991; c=relaxed/simple;
	bh=L9oTYqz7coCes4v46W8uTEssCznxNlmpxkBvoifmY60=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RHFlOPiHQMdlu3V3bMOk1AD93+571HLSGk2JPMYdArfZXwLxlIKQ6afy1bXtgWQk/FWNptvO6Ddc0R7leO8wUaO+4MMwFVGn5XxGdzGzVA4NFwNAa9sxe8HzHZKc1QmlsAsxXC9dhlhCA8mFJYeIC914YqQCOfw29eQE91nMZDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UVak6wRv; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UVak6wRv"
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de5a7b18acdso5511307276.3
        for <iommu@lists.linux.dev>; Tue, 30 Apr 2024 10:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714499989; x=1715104789; darn=lists.linux.dev;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=vseX6k1o+B5FqObwflCIgJI2bSMTOCAMOHrgjYjS0ao=;
        b=UVak6wRvu4gDNz2Bj2kT48IQFBiukK98UAKJMba9uH+KhNTpDrdCtRR8eMQHwXM9Yi
         LgI3uGGkXHyqVUJcD+bsUJGrondkZwQd77Rn1j4FIuebpx2dKsOyjS6FiJVXRgSAraSp
         rTtuEqKrsvwh0OrIAFDU/lGY+ep68fVscYHzGuhJsAA4LR26IDFM5kkNHsaPbJY5itwf
         YqSq2j98llPQnZwzLRgaEu7p3uC7EquZfti4HPmULoQz4KTkj8LwHDgEbUx0qqfqvdd3
         hK6z5ol3leIj8+efJhgjUv9dGFUWtWay66g2iPZyzdRRxLDfI2J2C6iiTeA48cz4pJGT
         UAgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714499989; x=1715104789;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vseX6k1o+B5FqObwflCIgJI2bSMTOCAMOHrgjYjS0ao=;
        b=RTMDgQZ1D/9DxQ++ncRryeRYABHNj3MX9RSPyR0QZCPGdbSIXzwc4MbrDPzh6r55X/
         5OtiRWJ0cPvR24QCpCJv402I4X3+GbIs6zQkHsulEXXXcerB+e+40LYn0/UKlWjVDtTf
         PpxIjzY7idLeuSYYDPpz4+7/wXfTXMCyjrgbEyGo27o1u2PaJBLizfLje6tB/X5OiDCD
         vyBCn350i/ZjujMQ51cNJUc09ivzEV8PgOKTryEvUVHrOqY6b/aL/puwCmWVcWxhnWTu
         2ZadrYV0wf/nyE2i061M1sVJRY6qCX4PPk4fv3Rj/ouxOyG3/9fmqJ49qKqdfhECLq8e
         HBxw==
X-Forwarded-Encrypted: i=1; AJvYcCWMdGPGmzL7WrPp/owlyFpd1f2dXS637Y9QorGYqAryFy8hsyu3uq13ieQS1Es42VWQDD5rJkDZzSikLfK1VdWkyUngMjg=
X-Gm-Message-State: AOJu0YwL4xrugIxTAbGMlaPtOq7B71lVf7BlEEqf+YNS7yFu5hAb+5m0
	majhsBUJi2S4Cjo25VFhqpOkxU4KOGZrbe/YiYa2xOe6LY+sQmboDRFI5/hOSzUERMDhQ0p7Bu8
	qObFaTFJQijFMGIUj3CEhYjB8dUpxlbwWY8OOmg==
X-Google-Smtp-Source: AGHT+IFxTsE2SveaRlTBhB+EE6DHBgwYOYt11ZOE5SdTfnq52tv68cpVnXh2QMmknwt5E8opTI/WtCOAflJ81I1ljMk=
X-Received: by 2002:a5b:648:0:b0:de4:7f18:4a3 with SMTP id o8-20020a5b0648000000b00de47f1804a3mr316138ybq.25.1714499989331;
 Tue, 30 Apr 2024 10:59:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
In-Reply-To: <20240123144543.9405-1-quic_bibekkum@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 30 Apr 2024 20:59:38 +0300
Message-ID: <CAA8EJpo2nU81K275eze9W_LyXwrrzP-u3DE2OaVfBgsVgHcK=Q@mail.gmail.com>
Subject: Re: [PATCH v9 0/5] iommu/arm-smmu: introduction of ACTLR
 implementation for Qualcomm SoCs
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>, Rob Clark <robdclark@gmail.com>, robin.murphy@arm.com, 
	will@kernel.org
Cc: joro@8bytes.org, konrad.dybcio@linaro.org, jsnitsel@redhat.com, 
	quic_bjorande@quicinc.com, mani@kernel.org, quic_eberman@quicinc.com, 
	robdclark@chromium.org, u.kleine-koenig@pengutronix.de, robh@kernel.org, 
	vladimir.oltean@nxp.com, quic_pkondeti@quicinc.com, quic_molvera@quicinc.com, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 16:46, Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> This patch series consist of five parts and covers the following:
>
> 1. Re-enable context caching for Qualcomm SoCs to retain prefetcher
>    settings during reset and runtime suspend.
>
> 2. Remove cfg inside qcom_smmu structure and replace it with single
>    pointer to qcom_smmu_match_data avoiding replication of multiple
>    members from same.
>
> 3. Introduce intital set of driver changes to implement ACTLR register
>    for custom prefetcher settings in Qualcomm SoCs.
>
> 4. Add ACTLR data and implementation operations for SM8550.
>
> 5. Add ACTLR data and implementation operations for SC7280.

Colleagues, just wanted to check, what happened to this series?

-- 
With best wishes
Dmitry
