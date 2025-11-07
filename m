Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71D17218596
	for <iommu@lists.linux.dev>; Fri,  7 Nov 2025 09:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762507858; cv=none; b=CvHjF7r3Ksi6OOrZCHg/xNrSw+G2u9hogi/Jn8XWzjiOuliSB58ZxdUM+EUM2K2Z2eY94glOrcrgdtF+y5mc0aBGro+JaNqesvFWFRPxF/LltWdLrRv11Xsy0aZB1WAMOY7cDzXZK63JAF66mwPRp4yPy6Q2hF5kaAv/L0gcrFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762507858; c=relaxed/simple;
	bh=4CZzcpxMHSZuRHsI8AlM8JSNzLEUVV4LARPB5vwqj3E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UepzOVzJ9tf7gH5l8BW5IpioFCIPoUbPYJzrhjUMOnvICAPbqg84MjyFzgBUzRKY6WzlwdfqowCDccn1U6ocaXNvg7J2PV1yzS2kgAF0dDkyNyhcExLIBKCBkQrnTmtO9rqZnFkZWL4qLyZ0yqJQlxfMx0wrs1jAx7uTPmdqYOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Zslv2Tz1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zslv2Tz1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762507855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tA7UGGTMV9n+J3uPxencDL7E+I6MFvKjlNZSpspgjhg=;
	b=Zslv2Tz1JRzruDP1l8O89MtfQMDMl7j9Rxd0+/v4MMtjGOBIpxTfMZUk2DnCjgYogwWge1
	fTDqCvtZ3oKMfj5melb6rOJhoqwznvYncntyieSjiOqNQjwE5VHUJFX0KVprT4TW7D1Gf5
	1Lhy2yoi0VReX237tnFWrrcQygRpuuc=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-98-oDRKdjcSPXeyCzceq1z8sw-1; Fri, 07 Nov 2025 04:30:52 -0500
X-MC-Unique: oDRKdjcSPXeyCzceq1z8sw-1
X-Mimecast-MFC-AGG-ID: oDRKdjcSPXeyCzceq1z8sw_1762507852
Received: by mail-oa1-f70.google.com with SMTP id 586e51a60fabf-3e1102f84feso108812fac.3
        for <iommu@lists.linux.dev>; Fri, 07 Nov 2025 01:30:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762507852; x=1763112652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tA7UGGTMV9n+J3uPxencDL7E+I6MFvKjlNZSpspgjhg=;
        b=AV2HoJwS5q0Z0vr1F8iw9NThqQplxOcq5953V0x2oFmMO1/GUpuvVfAPbbcahpvtKF
         5VWK1FkOFhUlOAWTCr7JRmyjyNV9M+EyXOZHVJdg/I7Y5DKIuN1djoGXdNtdMc/CJU49
         xwwlGJuhykn0PYkuD2z+O/OThYqs2+wyPU4zTKDJtHEBUhApBBKmngmljPMRcnBEbXhM
         YO7kavdwJLqHSzpXG8M0ShfDLFB6bOcclFKgKLj1duOF6MIJ4Bm+ICtg5m+qzyHpRfzU
         aRv4HOzxHE9u6MQBdzn1ZRiywufGpsxMq6ouhpW96bvV4vjl47Kopv83leNuXPB0P5i5
         GQrA==
X-Forwarded-Encrypted: i=1; AJvYcCUZNON9kpeYwjK6fwM2bkCJiu1epmlr1WlN+2yPum7olZo+EmEVbVCIH+R6PeRFT4ICAjo8mA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwjDHdGpej/juUEP4Qe+jJFeraDf84Y0gWOV8u633qmeNHHpGw5
	Px5mPTP7skuge5sqy+LU5i4NLJ9R711t0bfprvYRkiV+0T4tdXPwrma5l1Z0Sv2w2FTHuInPkgz
	K8n81lRiVcmW9NXZKTD8+P3EBmaYh6TtM5wuYpK7iKOL9liEYBWYt3w4MC/KULiZkHvcDo6MGsQ
	jHroi8IYq/4ZpHhYgT3rqd58yNs0g4JUw=
X-Gm-Gg: ASbGncuQQw/11IPvJrpr3hKUKO2+DrLr2lZOQ1zGm5mVluFoFWnd2Z1lyeArxAEMINN
	TNCcYVo7N8aCP79fbcSL8ZiRvX0Q6IHpbJ2JnmVRtkcfNNQvAebnWEzOfmn7QfUEfmAo39QqC3P
	uUaXIXAAWLF52ibEp0YxV8Lij6Tq90XT4iy2oMZUVOuF5TllCexZ6o
X-Received: by 2002:a05:6871:5b2a:b0:3c9:76e1:5e79 with SMTP id 586e51a60fabf-3e41e4ab7c7mr902883fac.3.1762507851761;
        Fri, 07 Nov 2025 01:30:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGH/Q8quC+L/fpo6hcTLMQP4gx99UOFXxVh08gtwqrZa5RrScApwJT7teFtONr4wGdKkHXevhtdORQ01LS2SNE=
X-Received: by 2002:a05:6871:5b2a:b0:3c9:76e1:5e79 with SMTP id
 586e51a60fabf-3e41e4ab7c7mr902858fac.3.1762507851194; Fri, 07 Nov 2025
 01:30:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20241212151402.159102-1-quic_bibekkum@quicinc.com>
In-Reply-To: <20241212151402.159102-1-quic_bibekkum@quicinc.com>
From: Enric Balletbo i Serra <eballetb@redhat.com>
Date: Fri, 7 Nov 2025 10:28:21 +0100
X-Gm-Features: AWmQ_blyT1f4Q3GxjMK__iwxj0lOKowHccrhgBcDwnM4U-WdAG0OXbr58R8HqnM
Message-ID: <CALE0LRupg93WsBVc62Lqt-T9qmK5MdEYoScxyP7=ttKJYXAsUA@mail.gmail.com>
Subject: Re: [PATCH v18 0/5] iommu/arm-smmu: introduction of ACTLR
 implementation for Qualcomm SoCs
To: Bibek Kumar Patro <quic_bibekkum@quicinc.com>
Cc: robdclark@gmail.com, will@kernel.org, robin.murphy@arm.com, 
	joro@8bytes.org, jgg@ziepe.ca, jsnitsel@redhat.com, robh@kernel.org, 
	krzysztof.kozlowski@linaro.org, quic_c_gdjako@quicinc.com, 
	dmitry.baryshkov@linaro.org, iommu@lists.linux.dev, 
	linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org, Maxime Ripard <mripard@kernel.org>, 
	Eric Chanudet <echanude@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QeFSYRKicj9hsH4MdIdD3Hd7KXLI1IiH0153bMEj9qE_1762507852
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 4:14=E2=80=AFPM Bibek Kumar Patro
<quic_bibekkum@quicinc.com> wrote:
>
> This patch series consist of six parts and covers the following:
>
> 1. Provide option to re-enable context caching to retain prefetcher
>    settings during reset and runtime suspend.
>
> 2. Remove cfg inside qcom_smmu structure and replace it with single
>    pointer to qcom_smmu_match_data avoiding replication of multiple
>    members from same.
>
> 3. Add support for ACTLR PRR bit setup via adreno-smmu-priv interface.
>
> 4. Introduce intital set of driver changes to implement ACTLR register
>    for custom prefetcher settings in Qualcomm SoCs.
>
> 5. Add ACTLR data and support for qcom_smmu_500.
>
> Changes in v18 from v17_RESEND:
>  - 1/5 : No changes
>  - 2/5 : No changes - reviewed-by tags collected
>  - 3/5 : Addition of
>    pm_runtime_resume_and_get()/pm_runtime_put_autosuspend()
>    around register access of PRR related private interfaces
>    as discussed in v17_RESEND.
>  - 4/5, 5/5 : No changes - reviewed-by tags collected
>  Link to v17_RESEND:
>  https://lore.kernel.org/all/20241114160721.1527934-1-quic_bibekkum@quici=
nc.com/
>
> Resend of v17:
>  Addition of minor fix of the build warning reported by kernel test robot=
 [1] by powerpc_random config [2].
>  [1]:https://lore.kernel.org/all/202411140748.6mcFdJdO-lkp@intel.com/#t
>  [2]:https://download.01.org/0day-ci/archive/20241114/202411140748.6mcFdJ=
dO-lkp@intel.com/config
>
> Changes in v17 from v16:
>  Tags provided earlier not collected yet on patch 1/5, 3/5, 4/5, 5/5
>  due to the following revisions:
>  - 1/5 : Move the CPRE workaround out of qualcomm specific logic and gate=
 with config
>          , update the silicon-errata.rst file
>  - 2/5 : No changes - reviewed-by tags collected
>  - 3/5 : Move the compatible check before assignment of callback as sugge=
sted.
>  - 4/5 : Add the actlr setting for *adreno variant* of MMU-500 as well.
>  - 5/5 : Due to changes in 1/5, minor refactoring had to be done before a=
dding table.
>  Link to v16:
>  https://lore.kernel.org/all/20241008125410.3422512-1-quic_bibekkum@quici=
nc.com/
>
> Changes in v16 from v15:
>  - Incorporate Dimitry's suggestion on patch 4/5 to use dev_dbg instead o=
f dev_notice.
>  - Fix kernel test robot warning [1] coming for 32bit architecture config=
uration.
>  - Updatingthe tags
>  [1]: https://lore.kernel.org/all/202409230343.Q8KnYl2w-lkp@intel.com/
>  Link to v15:
>  https://lore.kernel.org/all/20240920155813.3434021-1-quic_bibekkum@quici=
nc.com/
>
> Changes in v15 from v14:
>  - As discussed with Robin and Dmitry modify the actlr table and logic to=
 use
>    compatible string instead of sid, mask for device matching which is
>    similar to qcom_smmu_client_of_match mechanism.
>  - Expand the comment in qcom_smmu500_reset to document reason why CPRE b=
it is re-enabled again
>    after arm_mmu500_reset resets the bit.
>  - Rearrange the series in order to keep prefetch setting patches in the =
end.
>  Link to v14:
>  https://lore.kernel.org/all/20240816174259.2056829-1-quic_bibekkum@quici=
nc.com/
>

Hi all,

I've been looking at the evolution of the Qualcomm SMMU driver
(arm-smmu-qcom.c) and had a question about the design change for
configuring the SMMU_CB_ACTLR register.

It appears there are two different approaches:

1. The "SID" Approach (Older): In some versions, a driver would use a
large, platform-specific struct (e.g., sa8775p_apps_actlr_cfg) that
maps individual Stream IDs (SIDs) to specific ACTLR values. This
allowed for very granular, per-SID tuning. For example, a device with
10 SIDs could have a specific setting for just one (0x2141), while the
others used a default.

2. The "Compatible String" Approach (Newer/Upstream): The current
upstream driver appears to use a client_match array (an of_device_id
list) in qcom_smmu_init_context. This maps a device's compatible
string to a single ACTLR value, which is then written to the device's
assigned Context Bank.

I want to make sure I understand the implications of this new, simpler
approach, as it seems to introduce a trade-off where granularity is
lost:

Multiple SIDs, One Device: A single device that uses many SIDs in the
device tree (e.g., the video codec, which might list 0x2141, 0x25C1,
0x2161, etc.) will now have one ACTLR setting applied to the Context
Bank that serves all of those SIDs, even if the old SID-based list
only specified a setting for one of them.

Am I correct in this analysis? I'm assuming this was an intentional
design choice to simplify the driver, based on the assumption that all
SIDs for a single device (and all devices with the same compatible)
can share the same ACTLR tuning.

I'm working on porting settings for an sa8775p board and just want to
ensure I'm migrating the logic correctly to this new client_match
method.

Thanks for any clarification you can provide.

Best regards,

   Enric


> Changes in v14 from v13:
>  Patch 6/6:
>  - As discussed incorprate changes to carry out PRR implementation only f=
or
>    targets based on MMU-500 by using compat string based SMMU version det=
ection.
>  - Split the set_actlr interface into two separate interface namely set_p=
rr_bit
>    and set_prr_addr to set the prr enable bit and prr page address resepe=
ctively.
>  Patch 3/6:
>   - Fix a bug in gfx actlr_config which is uncovered while testing the gf=
x actlr setting in sc7280
>     during PRR experiment which prevented clients on certain sids of gfx =
smmmu to be skipped during
>     setting up of the ACTLR values : Fix involves swapping the arguments =
passed in smr_is_subset to make
>      device smr <from devicetree> a subset of actlr_config table entries =
< defined in the driver>.
>  Patch 4/6, 5/6:
>   - Sort the actlr table values in increasing order of the SIDs.
>  Link to v13:
>  https://lore.kernel.org/all/20240628140435.1652374-1-quic_bibekkum@quici=
nc.com/
>
> Changes in v13 from v12:
>  - Fix the compilation issues reported by kernel test robot [1].
>  [1]: https://lore.kernel.org/all/202406281241.xEX0TWjt-lkp@intel.com/#t
>  Link to v12:
>  https://lore.kernel.org/all/20240626143020.3682243-1-quic_bibekkum@quici=
nc.com/
>
> Changes in v12 from v11:
>  Changes to incorporate suggestion from Rob:
>  - Fix the set and reset logic for prr bit as pointed out in v11-6/6.
>  - Rename set_actlr_bit function name to set_prr.
>  - Add extension for PRR name as Partially-Resident-Region in comments
>    for set_prr function.
>  - Add few missing sids for sc7280 in patch-5/6.
>  Link to v11:
>  https://lore.kernel.org/all/20240605121713.3596499-1-quic_bibekkum@quici=
nc.com/
>
> Changes in v11 from v10:
>  - Include a new patch 6/6 to add support for ACTLR PRR bit
>    through adreno-smmu-priv interface as suggested by Rob and Dmitry.
>  Link to v10:
>  https://lore.kernel.org/all/20240524131800.2288259-1-quic_bibekkum@quici=
nc.com/
>
> Changes in v10 from v9:
>  - Added reviewed-by tags 1/5,2/5,3/5.
>  Changes incorporated:
>  - Remove redundant PRR bit setting from gfx actlr table(patch 4/5,5/5)
>    as this bit needs special handling in the gfx driver along with
>    the associated register settings.
>  Link to discussion on PRR bit:
>  https://lore.kernel.org/all/f2222714-1e00-424e-946d-c314d55541b8@quicinc=
.com/
>  Link to v9:
>  https://lore.kernel.org/all/20240123144543.9405-1-quic_bibekkum@quicinc.=
com/
>
> Changes in v9 from v8:
>  Changes to incorporate suggestions from Konrad as follows:
>  - Re-wrap struct members of actlr_variant in patch 4/5,5/5
>    in a cleaner way.
>  - Move actlr_config members to the header.
>  Link to v8:
>  https://lore.kernel.org/all/20240116150411.23876-1-quic_bibekkum@quicinc=
.com/
>
> Changes in v8 from v7:
>  - Added reviewed-by tags on patch 1/5, 2/5.
>  Changes to incorporate suggestions from Pavan and Konrad:
>  - Remove non necessary extra lines.
>  - Use num_smmu and num_actlrcfg to store the array size and use the
>    same to traverse the table and save on sentinel space along with
>    indentation levels.
>  - Refactor blocks containing qcom_smmu_set_actlr to remove block
>    repetition in patch 3/5.
>  - Change copyright year from 2023 to 2022-2023 in patch 3/5.
>  - Modify qcom_smmu_match_data.actlrvar and actlr_variant.actlrcfg to
>    const pointer to a const resource.
>  - use C99 designated initializers and put the address first.
>  Link to v7:
>  https://lore.kernel.org/all/20240109114220.30243-1-quic_bibekkum@quicinc=
.com/
>
> Changes in v7 from v6:
>  Changes to incorporate suggestions from Dmitry as follows:
>  - Use io_start address instead of compatible string to identify the
>    correct instance by comparing with smmu start address and check for
>    which smmu the corresponding actlr table is to be picked.
> Link to v6:
> https://lore.kernel.org/all/20231220133808.5654-1-quic_bibekkum@quicinc.c=
om/
>
> Changes in v6 from v5:
>  - Remove extra Suggested-by tags.
>  - Add return check for arm_mmu500_reset in 1/5 as discussed.
> Link to v5:
> https://lore.kernel.org/all/20231219135947.1623-1-quic_bibekkum@quicinc.c=
om/
>
> Changes in v5 from v4:
>  New addition:
>  - Modify copyright year in arm-smmu-qcom.h to 2023 from 2022.
>  Changes to incorporate suggestions from Dmitry as follows:
>  - Modify the defines for prefetch in (foo << bar) format
>    as suggested.(FIELD_PREP could not be used in defines
>    is not inside any block/function)
>  Changes to incorporate suggestions from Konrad as follows:
>  - Shift context caching enablement patch as 1/5 instead of 5/5 to
>    be picked up as independent patch.
>  - Fix the codestyle to orient variables in reverse xmas tree format
>    for patch 1/5.
>  - Fix variable name in patch 1/5 as suggested.
>  Link to v4:
> https://lore.kernel.org/all/20231215101827.30549-1-quic_bibekkum@quicinc.=
com/
>
> Changes in v4 from v3:
>  New addition:
>  - Remove actlrcfg_size and use NULL end element instead to traverse
>    the actlr table, as this would be a cleaner approach by removing
>    redundancy of actlrcfg_size.
>  - Renaming of actlr set function to arm_smmu_qcom based proprietary
>    convention.
>  - break from loop once sid is found and ACTLR value is initialized
>    in qcom_smmu_set_actlr.
>  - Modify the GFX prefetch value separating into 2 sensible defines.
>  - Modify comments for prefetch defines as per SMMU-500 TRM.
>  Changes to incorporate suggestions from Konrad as follows:
>  - Use Reverse-Christmas-tree sorting wherever applicable.
>  - Pass arguments directly to arm_smmu_set_actlr instead of creating
>    duplicate variables.
>  - Use array indexing instead of direct pointer addressed by new
>    addition of eliminating actlrcfg_size.
>  - Switch the HEX value's case from upper to lower case in SC7280
>    actlrcfg table.
>  Changes to incorporate suggestions from Dmitry as follows:
>  - Separate changes not related to ACTLR support to different commit
>    with patch 5/5.
>  - Using pointer to struct for arguments in smr_is_subset().
>  Changes to incorporate suggestions from Bjorn as follows:
>  - fix the commit message for patch 2/5 to properly document the
>    value space to avoid confusion.
>  Fixed build issues reported by kernel test robot [1] for
>  arm64-allyesconfig [2].
>  [1]: https://lore.kernel.org/all/202312011750.Pwca3TWE-lkp@intel.com/
>  [2]:
> https://download.01.org/0day-ci/archive/20231201/202312011750.Pwca3TWE-lk=
p@intel.com/config
>  Link to v3:
> https://lore.kernel.org/all/20231127145412.3981-1-quic_bibekkum@quicinc.c=
om/
>
> Changes in v3 from v2:
>  New addition:
>  - Include patch 3/4 for adding ACTLR support and data for SC7280.
>  - Add driver changes for actlr support in gpu smmu.
>  - Add target wise actlr data and implementation ops for gpu smmu.
>  Changes to incorporate suggestions from Robin as follows:
>  - Match the ACTLR values with individual corresponding SID instead
>    of assuming that any SMR will be programmed to match a superset of
>    the data.
>  - Instead of replicating each elements from qcom_smmu_match_data to
>    qcom_smmu structre during smmu device creation, replace the
>    replicated members with qcom_smmu_match_data structure inside
>    qcom_smmu structre and handle the dereference in places that
>    requires them.
>  Changes to incorporate suggestions from Dmitry and Konrad as follows:
>  - Maintain actlr table inside a single structure instead of
>    nested structure.
>  - Rename prefetch defines to more appropriately describe their
>    behavior.
>  - Remove SM8550 specific implementation ops and roll back to default
>    qcom_smmu_500_impl implementation ops.
>  - Add back the removed comments which are NAK.
>  - Fix commit description for patch 4/4.
>  Link to v2:
> https://lore.kernel.org/all/20231114135654.30475-1-quic_bibekkum@quicinc.=
com/
>
> Changes in v2 from v1:
>  - Incorporated suggestions on v1 from Dmitry,Konrad,Pratyush.
>  - Added defines for ACTLR values.
>  - Linked sm8550 implementation structure to corresponding
>    compatible string.
>  - Repackaged actlr value set implementation to separate function.
>  - Fixed indentation errors.
>  - Link to v1:
> https://lore.kernel.org/all/20231103215124.1095-1-quic_bibekkum@quicinc.c=
om/
>
> Changes in v1 from RFC:
>  - Incorporated suggestion form Robin on RFC
>  - Moved the actlr data table into driver, instead of maintaining
>    it inside soc specific DT and piggybacking on exisiting iommus
>    property (iommu =3D <SID, MASK, ACTLR>) to set this value during
>    smmu probe.
>  - Link to RFC:
> https://lore.kernel.org/all/a01e7e60-6ead-4a9e-ba90-22a8a6bbd03f@quicinc.=
com/
>
> Bibek Kumar Patro (5):
>   iommu/arm-smmu: re-enable context caching in smmu reset operation
>   iommu/arm-smmu: refactor qcom_smmu structure to include single pointer
>   iommu/arm-smmu: add support for PRR bit setup
>   iommu/arm-smmu: introduction of ACTLR for custom prefetcher settings
>   iommu/arm-smmu: add ACTLR data and support for qcom_smmu_500
>
>  Documentation/arch/arm64/silicon-errata.rst   |   3 +-
>  drivers/iommu/Kconfig                         |  12 ++
>  drivers/iommu/arm/arm-smmu/arm-smmu-impl.c    |   5 +-
>  .../iommu/arm/arm-smmu/arm-smmu-qcom-debug.c  |   2 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.c    | 120 +++++++++++++++++-
>  drivers/iommu/arm/arm-smmu/arm-smmu-qcom.h    |   3 +-
>  drivers/iommu/arm/arm-smmu/arm-smmu.h         |   2 +
>  include/linux/adreno-smmu-priv.h              |  14 ++
>  8 files changed, 155 insertions(+), 6 deletions(-)
>
> --
> 2.34.1
>
>

