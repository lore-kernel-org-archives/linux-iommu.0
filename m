Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954007E
	for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 10:12:41 +0000 (UTC)
Received: by mail-lj1-f180.google.com with SMTP id w15so7194315ljw.1
        for <iommu@lists.linux.dev>; Mon, 15 Aug 2022 03:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=pgmOEAhTB4c0Rk4dzh/uT4thgRDZIHmGfPeSwRRJ/84=;
        b=hnHCRK8Q+UxNpKPvzeerxtCOKBJH1jxjedRjN0LqDucNeVtuSVUGUXE8p3eN+HUAlA
         MXV6uTrfLlYPc9SKe0mw5fDa2UkUZp1RIX67iiPKuCxBVWz5CNSisa1J3e10ln2ZZZ6s
         MZVBG6YJ8LNf1kWiVBR+Gjl2oja2uYGWx5HCfupYYTYxzi/9mSQMjAKixx4te3EHyoNt
         lkIw7HFr+V12kj3oYgLDxcXaHxNl7LF0hpADsJDNcPrEhCDq7e74rLVuaS+ffDHItZGX
         auHafzn7A2K57uaJPVKZ9ukDucS0+D6ATjZoPT7W6/m6zrtjh9WmqmWCcc0Lob+ivxB6
         8t8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=pgmOEAhTB4c0Rk4dzh/uT4thgRDZIHmGfPeSwRRJ/84=;
        b=dBSodDRji8h4gbvxxaEpzG6keI5tPhL7RTfSr2L7IU8tptQRMEF0I5p4WgCkvO1pDk
         Sz4yWjVSf+JDKux2f0fRq/fDMz+yL6JEQ3aD1UgOmDhxhr5HEGj1cmDBUpEfI63+CLQR
         4UinyvD+3hodHmZQ+bsppnxTwy3l6h1EefygzK81iKqcibpI1HlFHwBhshaBv+881cJA
         fatscNF5yMs+lQTV0Zd6huOTyCyxLd0uGl9t+zWOyVxVHb8ecBWX0x1TV/irm3oCflih
         y6ub37I5mp5RJLP3PapgMwn6SQnpM9iMoTTWrnWn5fuCx3rNGsc0MBTaBkQKCOgJY80G
         ro/w==
X-Gm-Message-State: ACgBeo14G9U3Ew8FWJFGEtCBFtpRMmBFUi8/jjFJBjuBUlwE4yz0ZcYc
	0GiyDIKEAa2yFq9VMl/tdpc=
X-Google-Smtp-Source: AA6agR6OohB1gAlSOX87kZJXM0HKoTso5IZAqCd692ZEM35DA0cnjXRxTqWgNdhzVNadBobpNWF4Rw==
X-Received: by 2002:a2e:b88c:0:b0:25f:eae4:74ff with SMTP id r12-20020a2eb88c000000b0025feae474ffmr5030106ljp.48.1660558359743;
        Mon, 15 Aug 2022 03:12:39 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id 18-20020ac25f52000000b0048b1ba4d2a4sm1047264lfz.265.2022.08.15.03.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Aug 2022 03:12:39 -0700 (PDT)
From: Adam Skladowski <a39.skl@gmail.com>
To: 
Cc: phone-devel@vger.kernel.org,
	~postmarketos/upstreaming@lists.sr.ht,
	Adam Skladowski <a39.skl@gmail.com>,
	Andy Gross <agross@kernel.org>,
	Bjorn Andersson <bjorn.andersson@linaro.org>,
	Konrad Dybcio <konrad.dybcio@somainline.org>,
	Vinod Koul <vkoul@kernel.org>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Will Deacon <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Viresh Kumar <viresh.kumar@linaro.org>,
	Sai Prakash Ranjan <quic_saipraka@quicinc.com>,
	Loic Poulain <loic.poulain@linaro.org>,
	Emma Anholt <emma@anholt.net>,
	Rob Clark <robdclark@chromium.org>,
	Bhupesh Sharma <bhupesh.sharma@linaro.org>,
	linux-arm-msm@vger.kernel.org,
	dmaengine@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev,
	linux-mmc@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Sibi Sankar <sibis@codeaurora.org>,
	Adam Skladowski <a_skl39@protonmail.com>
Subject: [PATCH 4/7] cpufreq: Add SM6115 to cpufreq-dt-platdev blocklist
Date: Mon, 15 Aug 2022 12:09:42 +0200
Message-Id: <20220815100952.23795-5-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220815100952.23795-1-a39.skl@gmail.com>
References: <20220815100952.23795-1-a39.skl@gmail.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Qualcomm SM6115 platform uses the
qcom-cpufreq-hw driver, so add it to the cpufreq-dt-platdev driver's
blocklist.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index 2c96de3f2d83..6ac3800db450 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -146,6 +146,7 @@ static const struct of_device_id blocklist[] __initconst = {
 	{ .compatible = "qcom,sc8180x", },
 	{ .compatible = "qcom,sc8280xp", },
 	{ .compatible = "qcom,sdm845", },
+	{ .compatible = "qcom,sm6115", },
 	{ .compatible = "qcom,sm6350", },
 	{ .compatible = "qcom,sm8150", },
 	{ .compatible = "qcom,sm8250", },
-- 
2.25.1

