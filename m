Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2651B18858B
	for <iommu@lists.linux.dev>; Fri, 23 Aug 2024 16:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430670; cv=none; b=kWHGCtMI76+ICgCCKsHXXjNH1D8zG6fith+mS3bGsvgX0/iQFXxTdKQ+tgerzVhCOvkJjvtF0c8tLxGidFFsERMM08JhaJg7mfkJw009R1xKFCEqb3YUIZQKtgmk6BJ2A4CZZed2WfsEZR7NHRtMmlt5AA/bFm7c82BXztm82GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430670; c=relaxed/simple;
	bh=9lHM6b+ActxegeEXQPz6BAagep9zzVNwTWfk3BJdMHY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DEMrZTRVVZgNLefHq7Y/p6SgjVFFTrK9JBUu7SXtAR6ep/qYDMjO3HGJoeJNXugfFBKoER3RvuDwkLgF6Z+cndbZD6f4ti1SRj91qaTnNREt+OrQGFdQR3g6s202HbM2wZ5gwE3XBCznRwIwcTyRZ6mf3pa0oQUvrquwR9Ylbuo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYr78buC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYr78buC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7526FC4AF09;
	Fri, 23 Aug 2024 16:31:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724430669;
	bh=9lHM6b+ActxegeEXQPz6BAagep9zzVNwTWfk3BJdMHY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYr78buCC1gYGOI3tcrrxzpHtxq1YOovPXDlBfUJNorHY5LY2VCvDLrANvNbPy0XV
	 v7m7ZVuz36nSiCAr8A8rdd9p43ou08vyjQAIx7JFIUieNTdrGP7m2v/Kp7S0Z1F/Qt
	 fIZqpE4pIi/TByg4eynNhhnmOaTnabXknhz1f1cL2rrYEbibwUCcxhNHU2hi9vyXfS
	 QeaEvSxA0hQCkdU23xmo5+Y3nBRRgZixgCSJF6KHYbfRW/Lv/9vtWflgPRheTCSmNx
	 urTMTHPcAfFXCTioIWPdh5Uc34jtVXO4RDvXKN0qh8N/DRtBkJGHwdhmcTBCCke/IQ
	 DRoMh/sKY87Ew==
Date: Fri, 23 Aug 2024 17:31:05 +0100
From: Will Deacon <will@kernel.org>
To: Pranjal Shrivastava <praan@google.com>
Cc: Joerg Roedel <joro@8bytes.org>, Robin Murphy <robin.murphy@arm.com>,
	Mostafa Saleh <smostafa@google.com>, iommu@lists.linux.dev,
	Daniel Mentz <danielmentz@google.com>
Subject: Re: [PATCH] iommu/arm-smmu-v3: Print better events records
Message-ID: <20240823163104.GD851@willie-the-truck>
References: <20240816211722.1404070-1-praan@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240816211722.1404070-1-praan@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

Hi Pranjal,

On Fri, Aug 16, 2024 at 09:17:22PM +0000, Pranjal Shrivastava wrote:
> Currently, the driver dumps the hex for a received event, improve this
> by parsing out fields from an event for easier-to-read event records.
> 
> Signed-off-by: Daniel Mentz <danielmentz@google.com>
> Signed-off-by: Pranjal Shrivastava <praan@google.com>
> ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 102 ++++++++++++++++++--
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h |  10 ++
>  2 files changed, 105 insertions(+), 7 deletions(-)

Thanks for doing this. I've got used to the useless messages we currently
print, but this will be a tonne beter.

> 
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index a31460f9f3d4..993ded10c7b1 100644
> --- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -1783,9 +1783,102 @@ static int arm_smmu_handle_evt(struct arm_smmu_device *smmu, u64 *evt)
>  	return ret;
>  }
>  
> +static void arm_smmu_print_evt_record(struct arm_smmu_device *smmu, u64 *evt)
> +{
> +	static const char * const evts[] = {
> +		/* Bad config events */
> +		[EVT_ID_BAD_SID_CONFIG] = "C_BAD_STREAMID",
> +		[EVT_ID_BAD_STE_CONFIG] = "C_BAD_STE",
> +		[EVT_ID_BAD_CD_CONFIG] = "C_BAD_CD",
> +		[EVT_ID_BAD_SSID_CONFIG] = "C_BAD_SUBSTREAMID",
> +		[EVT_ID_STREAM_DISABLED] = "F_STREAM_DISABLED",
> +
> +		/* Bad translation events */
> +		[EVT_ID_TRANSLATION_FAULT] = "F_TRANSLATION",
> +		[EVT_ID_ADDR_SIZE_FAULT] = "F_ADDR_SIZE",
> +		[EVT_ID_ACCESS_FAULT] = "F_ACCESS",
> +		[EVT_ID_PERMISSION_FAULT] = "F_PERMISSION",
> +
> +		/* Bad fetch events */
> +		[EVT_ID_STE_FETCH_FAULT] = "F_STE_FETCH",
> +		[EVT_ID_CD_FETCH_FAULT] = "F_CD_FETCH",
> +		[EVT_ID_VMS_FETCH_FAULT] = "F_VMS_FAULT"
> +	};
> +
> +	static const char * const class_str[] = {
> +		[0] = "CD",
> +		[1] = "TTD",
> +		[2] = "IN",
> +		[3] = "RES",
> +	};

You can move these arrays out of this function...

> +
> +	const char *master_name = "(unassigned sid)";
> +	struct arm_smmu_master *master;
> +	u64 iova, ipa;
> +	bool ssid_valid;
> +	u32 sid, ssid;
> +	u8 evt_id, class;
> +	int i;
> +
> +	/* Pick out the good stuff */
> +	evt_id = FIELD_GET(EVTQ_0_ID, evt[0]);
> +	sid = FIELD_GET(EVTQ_0_SID, evt[0]);
> +	ssid_valid = evt[0] & EVTQ_0_SSV;
> +	ssid = ssid_valid ? FIELD_GET(EVTQ_0_SSID, evt[0]) : IOMMU_NO_PASID;
> +	class = FIELD_GET(EVTQ_1_CLASS, evt[1]);
> +	iova = FIELD_GET(EVTQ_2_ADDR, evt[2]);
> +	ipa = FIELD_GET(EVTQ_3_IPA, evt[3]);

You could encapsulate this in e.g.

	struct arm_smmu_event {
		u8	id;
		u32	sid;
		u32	ssid;
		...
		u64	*raw;
	};

> +
> +	mutex_lock(&smmu->streams_mutex);
> +	master = arm_smmu_find_master(smmu, sid);
> +	if (master)
> +		master_name = dev_name(master->dev);
> +	mutex_unlock(&smmu->streams_mutex);
> +
> +	switch (evt_id) {
> +	case EVT_ID_BAD_SID_CONFIG:
> +	case EVT_ID_BAD_STE_CONFIG:
> +	case EVT_ID_BAD_SSID_CONFIG:
> +	case EVT_ID_BAD_CD_CONFIG:
> +	case EVT_ID_STREAM_DISABLED:
> +		dev_err(smmu->dev, "Bad smmu config - %s client %s sid 0x%08x.0x%05x\n",
> +				evts[evt_id], master_name, sid, ssid);
> +		break;

and have separate dumper functions here, I think.

> +	case EVT_ID_TRANSLATION_FAULT:
> +	case EVT_ID_ADDR_SIZE_FAULT:
> +	case EVT_ID_ACCESS_FAULT:
> +	case EVT_ID_PERMISSION_FAULT:
> +		dev_err(smmu->dev, "Translation fault:\n");
> +		dev_err(smmu->dev, "\t%s client %s sid 0x%08x.0x%05x: iova = %#llx ipa = %#llx (%s%s%s%s%s%s)\n",
> +			    evts[evt_id], master_name, sid, ssid, iova, ipa,
> +			    FIELD_GET(EVTQ_1_PnU, evt[1]) ? "Priv " : "Unpriv ",
> +			    FIELD_GET(EVTQ_1_InD, evt[1]) ? "Inst " : "Data ",
> +			    FIELD_GET(EVTQ_1_RnW, evt[1]) ? "Read " : "Write ",
> +			    FIELD_GET(EVTQ_1_S2, evt[1]) ? "S2 " : "S1 ", class_str[class],
> +			    ((evt_id == EVT_ID_PERMISSION_FAULT) && (class == EVTQ_1_CLASS_TT)) ?
> +			    (FIELD_GET(EVTQ_1_TT_READ, evt[1]) ? " TTD Read" : " TTD Write")
> +			    : "");

i.e. call arm_smmu_dump_translation_fault(&event) here.

> +		break;
> +
> +	case EVT_ID_STE_FETCH_FAULT:
> +	case EVT_ID_CD_FETCH_FAULT:
> +	case EVT_ID_VMS_FETCH_FAULT:
> +		dev_err(smmu->dev, "Unable to fetch data structure - bad fetch address\n");
> +		dev_err(smmu->dev, "\t%s client %s sid 0x%08x.0x%05x: fetch addr = %#llx\n",
> +				evts[evt_id], master_name, sid, ssid, ipa);
> +		break;
> +	}
> +
> +	dev_info(smmu->dev, "event 0x%02x received:\n", evt_id);
> +	for (i = 0; i < EVTQ_ENT_DWORDS; ++i)
> +		dev_info(smmu->dev, "\t0x%016llx\n",
> +			 (unsigned long long)evt[i]);
> +}

We should probably be consistent with dev_info() vs dev_err().

Will
