Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27C53C2D
	for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 12:54:12 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id m22so35711971eji.10
        for <iommu@lists.linux.dev>; Tue, 15 Nov 2022 04:54:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4z+vcQIa+TDGxCARqFIzwt2He1hOQxmdiWKApcem7GQ=;
        b=YBur8QGH9B9DZJb9Crmk5KuOxYHrJWzxdseDQl+IeoL+2tRYVKgX79q6/QfRdi2v4i
         dGVvct0uk34s0I8Tj5z+wSNuYem5A2EDF+VqbvgbdeL2r+/u25BGmPePMAOp1TGcpigK
         ycjgIAhVgYGfsGJPY7xcvVLepm4KgYt1RwuMbyjRgjJzGldhtsX+QgriBy/0r3aJtUC1
         8e8xjsBUwqb3kmcidNMjfc4clzDOMhbgE5co459zupfdmvYmonS63k45OqPQRbmpv7q0
         VUJoV0lSgfvHdijK1wrLvRE/RGe68xeSzJzC71XB9PVBpcxorwRHPAMA4JPh7+RQ56t1
         boyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4z+vcQIa+TDGxCARqFIzwt2He1hOQxmdiWKApcem7GQ=;
        b=GDpE8aEZXZtC+qAUzqmM8qzBMPhIuiNy9XPEdOkI23I82PcBbcyImyAGf8f2iWbpTi
         VdfSJ1LQbG4wDlTuQH5tloqu9u2OWNk+iQtR7gzpFd/ke6gzSdeOVmzWX4RY2qGuQtzY
         pQuLm0ASDewmhpANI46kboE4F9BQCGv31b1WjF0BeqEMtdUYuiesmZafMScQiC9gF6k9
         YAW1ITiIXc2/Lm/qr2EYcreBoJZzIawaxdHAVeDAIGZLK3Rlt26ddq25tvtAsT13mikt
         uuM3ZUmMiWuauM/fvc/aFHfGNdSGEuS6AUvvDpe9gitSQSq9NydHfQl0G3Dr8g6HLlgB
         CEWQ==
X-Gm-Message-State: ANoB5pk91QYrBE+GqJIbwT/ohjoHhYfjmtmqsknOqADKFi62QAOChwU5
	LvfhHmwwFyL/+n4SshILUIykgQ==
X-Google-Smtp-Source: AA0mqf7itE9nf4WRqEIO+vTD+BPP7Gr3FkphD9bLXegoH3gu+/hOfOjZOYe3Gji0QSO05rw767Q+hQ==
X-Received: by 2002:a17:907:770f:b0:78d:c16e:dfc9 with SMTP id kw15-20020a170907770f00b0078dc16edfc9mr13754413ejc.327.1668516850970;
        Tue, 15 Nov 2022 04:54:10 -0800 (PST)
Received: from [192.168.31.208] ([194.29.137.22])
        by smtp.gmail.com with ESMTPSA id c2-20020a17090618a200b007ad96726c42sm2946289ejf.91.2022.11.15.04.54.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 04:54:10 -0800 (PST)
Message-ID: <f59ddce1-c2e1-4055-3bce-1319c68ddf94@linaro.org>
Date: Tue, 15 Nov 2022 13:54:03 +0100
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [PATCH v2 1/9] dt-bindings: arm-smmu: Allow up to 3 power-domains
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-arm-msm@vger.kernel.org, andersson@kernel.org, agross@kernel.org
Cc: patches@linaro.org, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221114104222.36329-1-konrad.dybcio@linaro.org>
 <20221114104222.36329-2-konrad.dybcio@linaro.org>
 <6fa8e3ea-2113-d930-96bc-3726d53e5bcd@linaro.org>
 <a4b160d8-0faa-3f4c-a925-0beaf6ace721@linaro.org>
 <0121fc03-b027-7659-5e6e-b42089c9888d@linaro.org>
 <12578e05-ced9-e5f7-7922-0af2f2159333@linaro.org>
 <878402e7-7f80-31c7-3a6b-989a6ca29841@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <878402e7-7f80-31c7-3a6b-989a6ca29841@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 14/11/2022 17:58, Krzysztof Kozlowski wrote:
> On 14/11/2022 16:53, Konrad Dybcio wrote:
>>
>> On 14/11/2022 14:00, Krzysztof Kozlowski wrote:
>>> On 14/11/2022 12:17, Konrad Dybcio wrote:
>>>> On 14/11/2022 12:01, Krzysztof Kozlowski wrote:
>>>>> On 14/11/2022 11:42, Konrad Dybcio wrote:
>>>>>> Some SMMUs require that a vote is held on as much as 3 separate PDs
>>>>>> (hello Qualcomm). Allow it in bindings.
>>>>>>
>>>>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>>>>> ---
>>>>>> Changes since v1:
>>>>>> - Add minItems
>>>>>>
>>>>>>     Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 3 ++-
>>>>>>     1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>>>> index 9066e6df1ba1..82bc696de662 100644
>>>>>> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>>>> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
>>>>>> @@ -159,7 +159,8 @@ properties:
>>>>>>               through the TCU's programming interface.
>>>>>>     
>>>>>>       power-domains:
>>>>>> -    maxItems: 1
>>>>>> +    minItems: 0
>>>>> It cannot be 0.
>>>>>
>>>>> minItems: 1
>>>>>
>>>>> Anyway you still need to restrict it per variant, as I said in previous
>>>>> version.
>>>> Hm.. I'm not entirely sure what you mean.. Should I add a list of
>>>> compatibles
>>> Yes and limit it to maxItems: 1 for "else".
>>
>> I tried adding:
>>
>>
>>
>>     - if:
>>         properties:
>>           compatible:
>>             contains:
>>               enum:
>>                 - qcom,sm6375-smmu-500
>>       then:
>>         properties:
>>           power-domains:
>>             minItems: 3
>>             maxItems: 3
>>       else:
>>         properties:
>>           power-domains:
>>             maxItems: 1
>>
>>
>> Right under the nvidia reg if-else in the allOf, but dtbs_check throws
>> errors like:
>>
>>
>> /home/konrad/linux/arch/arm64/boot/dts/qcom/msm8998-sony-xperia-yoshino-poplar.dtb:
>> iommu@5040000: 'power-domains' does not match any of the regexes:
>> 'pinctrl-[0-9]+'
>>
>>
>> Any clues as to why?
> 
> I don't know what code do you have there, but generic pattern is:
> 
> https://elixir.bootlin.com/linux/v5.19-rc6/source/Documentation/devicetree/bindings/clock/samsung,exynos7-clock.yaml#L38
> 
I tried many things, but I still don't seem to get a hang of it.. Here's 
my current diff rebased on top of Dmitry's recent cleanups (available at 
[1])


diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml 
b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
index 28f5720824cd..55759aebc4a0 100644
--- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
+++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
@@ -200,7 +200,7 @@ properties:
      maxItems: 7

    power-domains:
-    maxItems: 1
+    maxItems: 3

    nvidia,memory-controller:
      description: |
@@ -364,6 +364,26 @@ allOf:
              - description: interface clock required to access smmu's 
registers
                  through the TCU's programming interface.

+  - if:
+      properties:
+        compatible:
+          contains:
+            const: qcom,sm6375-smmu-500
+    then:
+      properties:
+        power-domains:
+          items:
+            - description: SNoC MMU TBU RT GDSC
+            - description: SNoC MMU TBU NRT GDSC
+            - description: SNoC TURING MMU TBU0 GDSC
+
+      required:
+        - power-domains
+    else:
+      properties:
+        power-domains:
+          maxItems: 1
+
  examples:
    - |+
      /* SMMU with stream matching or stream indexing */


In my eyes, this should work, but I still get errors like:

/home/konrad/linux/arch/arm64/boot/dts/qcom/sm8250-hdk.dtb: 
iommu@3da0000: power-domains: [[108, 0]] is too short

as if the else: path was never taken..

[1] 
https://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git/log/?h=for-joerg/arm-smmu/bindings

Konrad
> Best regards,
> Krzysztof
> 
