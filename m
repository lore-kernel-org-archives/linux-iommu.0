Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794860480;
	b=Lm/0njjEOED5QGwHLR2oKAhnI1mWcfMMV368y7N4WejrAH7rK6diIEYnAfaev0E/0bta
	 pdJhnhfdFRkTVjdgeB/IhemXM7yHQc4yRHwTaEPTqnBo9sltVt3IYpET/xxZo33I/g/mp
	 HRX6/yLRD2ITiPciBJKhQTooMaRuh18i316s8yiqMN4kaI1sCa4G5MhKSSfbJaSCVZoJm
	 0hiecWvmoiRMtPLSLvobhqgtB0nug2tYpIqxfSnrBAmFf/XNo0uhFM+LXpl1foSWMRt3/
	 Rpszst6bTklEpw5MPL6mRJID1DSTZqa3/1VCVdoij9T9e1x7o+GYUuB9Qmk4PiVDnjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794860480;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=WAVGrLOqbtuBnC4+1ihcRnARHmIEiLD/UVEgb+xsGxo=;
	b=g6yHGeApA0ZLMmCI2Snmh66ssNBD+7cvQoTLTExQWEA2I019M9eztz6aSrPyiWNi9AZR
	 MzT6RXCh7CWEAYnB8N3BU3+77IEpXX55nVPoOzrbuZMixbCYTla/7y+pdXrNfLo5IX4Gj
	 HpZPpHcnGpC/sv9x6h+1lRiGGcAAB1Z+s2WcR6cSXz1EfhUDo4s81e4b2aDai3vo3pXlS
	 s9U6aYZx+DI0YJeMHjrcTwKht7EGhGBM0QIWv+neG4XCvXxdIGmra1wa9ZOsJrIon9P8y
	 1WitjqucrETNMyn2JHHuqhde9CrYY7oBx2SO7SUoOJ9smiFUiBVsNMEF0XunsPdeYiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iGnLqu+i;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DF2606A32A
	for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 20:21:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8DF2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=iGnLqu+i
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-1b0739d31b9so1154c88.0
        for <iommu@lists.linux.dev>; Mon, 16 Nov 2026 12:21:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794860479; x=1795465279; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=WAVGrLOqbtuBnC4+1ihcRnARHmIEiLD/UVEgb+xsGxo=;
        b=iGnLqu+iQlTwSYhlzWIKuADY/0Q7v7sS7I2ghdd0fSoJZcl3OjYZE/BY9WXHFth3K0
         gCkwFRphFbTGcjaJu6M6LFyfPMQBXDVduDjxAylVM0Y7OJvnOVEyyhfKxvB6n/Yyvs32
         VmcZ2pSfInJ6CLYa+9/2LX69qWdRmWTmjHyWFPORV7LkUyzIGfiX8DSi5NKFyDMMJI7v
         igZvfcF2ccjt9pcKGeFM8BOF+8x1Vdko4mp3vC9DG6GWmGSfG51EgQ+RGnZ/GwWx+6n4
         BAdrrxzUBtZz1Vm7rICclwmYCxSXu3cSF9kV/29+OOQIWBXoVPf0JRoJbRoSW1wJ9vwA
         X+qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794860479; x=1795465279;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=WAVGrLOqbtuBnC4+1ihcRnARHmIEiLD/UVEgb+xsGxo=;
        b=EnZ44RfYDAc5ADO+9OAKCqhZy4jGHNFMkMc66eFKoAM4xSFWZM0cfTx9cBWZMTnQ/a
         hH78Xriroc4MrPa+lh6sVwxlFJl+Uhn/vd9qonVE9YV+ug34ZkohRKzZF2q2U+vEwxFR
         AYWPpzhVPg+aDQ2JpPa9cLMAQrZSEGtM6PzjDW7pKXQKD2OZPRHuWJa36EJ9Vag9jSOR
         GGZQNdfjNPkXKLZiwdlzXhceu69gGJkgY6WRmPBRVq70fxQmjD9fQAig4BQex3k4xzdJ
         de+y7WUgtN4MAFPc2NtqRe73mODlH9B1alVPjgcQdxxWBk2j5lfnB9qFvarwWnBMmg91
         Mx5Q==
X-Forwarded-Encrypted: i=1; AL+hErHsFkEXdqYZwF+3hO4s2XMDZaz5QI0sKgDHCy6iijO3W5bPJF1sksnzU5IsZf9IMHtZGR54DA==@lists.linux.dev
X-Gm-Message-State: APuU4Z/2480WYJjBLQi3tEFahYy2hdqMPq1TUG1iqCHXcJC1/7WbVoad
	ll4NcrkQKILaDd2TApGuvmPSwYmJFDUxg+VfcldB8V7jrEGmRIT6kbPCYe5vV0sESQ==
X-Gm-Gg: AYBFou2AIaEpX3VaW7rGwYMUFoJeNFT47+gLHZTIO1xp+qq6LggAtCXAMfzURMmEFGS
	gdsgi3M4WtRZLAq2WFaaOTa/mKwH1ec7u3KJx4Ut0N2PBWYhTv+j3XUPzyZnfkzdl1evn3BS2B5
	arZ/PoXTbLWPsFiVuAGi8OjZeagILNBizlRttJwTJkyp4ukwVPMy3dCwD9wrWEGtBGtBW1zEqZj
	+YZZJAP9h96zxWNPW/6T7utQMUbW4z3hos0hJK1h7PRuORQBU97sVM4kcjx8B/5H75EmwsHbiT/
	FiqAk0hk8AkBGSf/yvUCqTOGhk4E6VCc4lZ28kN1T6NWYQofJvhl82PEpmKQ5NmJYc505RC3T0C
	7CoXS8e2NHGKzR8wx+/ngoZRIp5Gri+DhTHrHWrD/k9p3TRTdBPbd3Vhg44C6vwOL/cAgodOR8G
	piyGf03Wr3TzTe8VYx/a+ZBh3IoTvDcHtqFS8QITftkMqhdeaetIjEvmNTtvgx5G2fBNFSebcXu
	L+GTTczhyFsDn1SF281MgGMOLocSJ9V1KL+R/fP8EZxTEdQUcGnBWMTu805TSk38+hhAI9qRZyS
	ip8B++8ZyPppOAXg8u0avcIwh8fsJtqURKxfIRi0aDypQfrFPa5GjgA9AtgrT7fcr0Q=
X-Received: by 2002:a05:701a:ccdc:20b0:186:2ed4:45e1 with SMTP id a92af1059eb24-1b53b17f2afmr5158c88.7.1794860477872;
        Mon, 16 Nov 2026 12:21:17 -0800 (PST)
Received: from google.com (105.211.142.34.bc.googleusercontent.com. [34.142.211.105])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3795378d7e5sm36665165eec.3.2026.11.16.12.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 12:21:16 -0800 (PST)
Date: Mon, 16 Nov 2026 20:21:11 +0000
From: Pranjal Shrivastava <praan@google.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Nicolin Chen <nicolinc@nvidia.com>, Kevin Tian <kevin.tian@intel.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	Joerg Roedel <joro@8bytes.org>, Peter Shier <pshier@google.com>,
	iommu@lists.linux.dev
Subject: Re: [PATCH v2] iommu: Honor iommufd uapi for zero entry_num args
Message-ID: <avtltxy9sp6cYiEP@google.com>
References: <20261112151039.2083705-1-praan@google.com>
 <avdO5cBwc/2ysstZ@nvidia.com>
 <avromFJ6opeGEcT_@google.com>
 <20261116130832.GC1850935@nvidia.com>
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Post: <mailto:iommu@lists.linux.dev>
List-Help: <mailto:iommu+help@lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
List-Owner: <mailto:iommu+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116130832.GC1850935@nvidia.com>

On Mon, Nov 16, 2026 at 09:08:32AM -0400, Jason Gunthorpe wrote:
> On Mon, Nov 16, 2026 at 11:27:20AM +0000, Pranjal Shrivastava wrote:
> > On Fri, Nov 13, 2026 at 09:54:45AM -0800, Nicolin Chen wrote:
> > > On Thu, Nov 12, 2026 at 03:10:39PM +0000, Pranjal Shrivastava wrote:
> > > > @@ -556,7 +556,8 @@ static inline int __iommu_copy_struct_from_user_array(
> > > >   * @data_type: The data type of the @kdst. Must match with @user_array->type
> > > >   *
> > > >   * Copy the entire user array. kdst must have room for kdst_entry_size *
> > > > - * user_array->entry_num bytes. Return 0 for success, otherwise -error.
> > > > + * user_array->entry_num bytes. An empty array copies nothing, though its
> > > > + * @data_type is still validated. Return 0 for success, otherwise -error.
> > > >   */
> > > >  static inline int
> > > >  iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
> > > > @@ -569,7 +570,7 @@ iommu_copy_struct_from_full_user_array(void *kdst, size_t kdst_entry_size,
> > > >  	if (user_array->type != data_type)
> > > >  		return -EINVAL;
> > > >  	if (!user_array->entry_num)
> > > > -		return -EINVAL;
> > > > +		return 0;
> > > 
> > > TBH, this doesn't seem very necessary..
> > > 
> > > Though I don't have a problem so long as Jason is okay with it..
> > > 
> > 
> > I know it looks unnecessary in-tree, but zero-length is the documented
> > way to check if a @data_type is supported.
> 
> Is it? I though it was put in 0 length and look for EOPNOTSUPP,
> success is not expected.
> 

Reading the uAPI comment [1] gives me that understanding:

 /*
  * An empty invalidation request array by setting @entry_num==0 is
  * allowed, and @entry_len and @data_uptr would be ignored in this case.
  * This can be used to check if the given @data_type is supported or
  * not by kernel.
  */

Hence, for a supported data_type I expect success..
Also, the selftests check exactly that [2]. An unsupported data_type gets
-EINVAL from the drivers today, not -EOPNOTSUPP (happy to switch if you
prefer).

Thanks,
Praan

[1] https://elixir.bootlin.com/linux/v7.4-rc1/source/include/uapi/linux/iommufd.h#L987
[2] https://elixir.bootlin.com/linux/v7.4-rc1/source/tools/testing/selftests/iommu/iommufd.c#L532
