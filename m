Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C6C411627
	for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 18:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774636819; cv=none; b=AzeD5Ujs4ACMb+koR+ra7Z4m8/kY9znzP7ebPHIsvm+RPyX3sG1gEuTLr2DPK7hK/5nZsJ++TUZqH1QgP4VIYFOS4lPYTmnwDpzOZ5LeuZ886sIx6p8tIVhHrygNBrDvpHz+QZuU0G2LgGyiPsZu5NQ+UzzBiuHvJUJmP8Kh8Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774636819; c=relaxed/simple;
	bh=68/qiY0dXiAzVFpmtFhIqp6f2IQFnIyj0gIBzOCT9pU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n/Ouna3fj9SgUp6zmuB+yNHPMEgZ20tnYWZTzu9GKetGsjuCk70LW6NBOnmKZjn2aX1rx0hFPrknMp5kCZLjHoElar6DVf/UDtBXhi5JPv3f+DLibUzz6eTlR1KJsvCujb1ldMrMU5YgnpcOdgH+Ugp43WzcJCHU3bGYHMG2wMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sDY4sfA0; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sDY4sfA0"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b0c12be0ecso14055ad.0
        for <iommu@lists.linux.dev>; Fri, 27 Mar 2026 11:40:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774636816; x=1775241616; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0IHrdY81PRz9ZLomdNE3Lco/cvsoDmUDbtnq/OEDTzA=;
        b=sDY4sfA0lvZjCTY171Z+AO07xXM3oI27wDDwBXEOffQtcbJZWcVDKV1Q7koK8zumFT
         1n3+nn5nvQlVKVVVYO+EFhxyAi3IdaQqM8wzsuO6obx+K6cjVQ2b21+mLktJDjDhf32L
         MfZPh3WLOi6o+XGppb9igU7saide4Mef3+cw75g6IJwU3jIRCsCX0iVpzMWSpU6jrCkv
         kBmPTAWyULFGpF+bKqyP8WK+FbCIQDR7sCkLrISIljDg6yYVXqEs94Ge6IxHwNdAvjzm
         s9WsZOAtz4JzTiRUc2sbi1JPeAMfXksINoE6gQIyCffYn9/iALh6TH4fT9A8Eus6h6ln
         a3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774636816; x=1775241616;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0IHrdY81PRz9ZLomdNE3Lco/cvsoDmUDbtnq/OEDTzA=;
        b=sA0OioUCCu6N8S95XQdB8PADT41QOka/Sc/zvTyPIP4Q0MrcN8+kvauaIsNFDrIb3M
         KAIPw3ZAn3PjSDGQ+mK88wpEo1AAF2vIG7AF1FQurNAj91Ep1gtt7l0ofGIY/UNsBiCr
         T0rnXTGq5c1r2RDioXtt3ZrKLUNA4bx8hoKxVQJVVjf2KEj2lc8fLOTN7FgmDMcvM/Go
         HeZ26UlyXzEgbFV6+NbP3CXSPqaZvMD7JIBUGX0iZ/Xdsv0OjhuiNrBKEENWz7vR5lVs
         zgp4U8wrBtHaVl5RL9OpIoW71e9OgBTU+qC4mBm9H1Jgqb/Y7Ki9smV7z+AemSkqO34R
         nFnw==
X-Forwarded-Encrypted: i=1; AJvYcCVllkhCkYM8kZuLWimoge1i/ObPgQ3tSdrLQIMjV9Eyx3N2xbTo+64NMmy4/bCXdat/NUiEvA==@lists.linux.dev
X-Gm-Message-State: AOJu0YxUhWsmhjox0FGtTPqm5CiUSvx53/HSrDnogprx6nKojdrXVrOz
	f9fFAP+TNXd2Q94imrkvq/TT2vdyr5qeOx8p5jLrKOqcJcysAHctgmuQV+SHL/YXXg==
X-Gm-Gg: ATEYQzzjsR3aGG7X9Z5Z3SfhXptUNF6BG/WD84t/8PqKudpfdLsiMoYFpRzQfhwJ7qj
	bAssEpH/tsvTOXy+xovVq9XX7xl1O0L4OfYGihQOMXoDCoKV60+zyyNcLf0yYFombkgnJQ/njn6
	J0DXa1SsujbM6O7u68DOBxZOMLurNYWxpKY3O2ERzRK2UkBuYPpuVoxwpK14eoKNVJnwL0fy8pJ
	hqkCKgv0h5SPsNzGtQa8nI31Ej8+snW+nIni9CIegrPSok1bU1sgZlhKF3o8eYDW1d34K1bBHne
	zRMsG3KcTT4Df5V/albY30Ecl5wsqMm8+fHB/6SBi+2pqGIgorsEdWo+dEyqdejIqzFVLOmj+TG
	mUHglqWzzn5f6Rt6wlR48RaEy5WT5iJX7IG+D2u9k1tWpgYSRoRSykzq8abrmk3+fJewFzIFuE+
	I+wXNEbX/DO95UgwzSOwL1Q7+Lq8WYm4kM+dyjN1/V6vTAIpCjy5l6XrR9lSuJwA==
X-Received: by 2002:a17:902:e5c6:b0:2b0:5683:1cf with SMTP id d9443c01a7336-2b241e48c27mr315445ad.13.1774636815223;
        Fri, 27 Mar 2026 11:40:15 -0700 (PDT)
Received: from google.com (168.136.83.34.bc.googleusercontent.com. [34.83.136.168])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82c7d388e5esm6639001b3a.37.2026.03.27.11.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 11:40:14 -0700 (PDT)
Date: Fri, 27 Mar 2026 18:40:10 +0000
From: Samiullah Khawaja <skhawaja@google.com>
To: Pranjal Shrivastava <praan@google.com>
Cc: David Woodhouse <dwmw2@infradead.org>, 
	Lu Baolu <baolu.lu@linux.intel.com>, Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>, 
	Jason Gunthorpe <jgg@ziepe.ca>, Robin Murphy <robin.murphy@arm.com>, 
	Kevin Tian <kevin.tian@intel.com>, Alex Williamson <alex@shazbot.org>, 
	Shuah Khan <shuah@kernel.org>, iommu@lists.linux.dev, linux-kernel@vger.kernel.org, 
	kvm@vger.kernel.org, Saeed Mahameed <saeedm@nvidia.com>, 
	Adithya Jayachandran <ajayachandra@nvidia.com>, Parav Pandit <parav@nvidia.com>, 
	Leon Romanovsky <leonro@nvidia.com>, William Tu <witu@nvidia.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Pasha Tatashin <pasha.tatashin@soleen.com>, 
	David Matlack <dmatlack@google.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Chris Li <chrisl@kernel.org>, Vipin Sharma <vipinsh@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Subject: Re: [PATCH 14/14] iommufd/selftest: Add test to verify iommufd
 preservation
Message-ID: <acbOSmcvNTP92CoP@google.com>
References: <20260203220948.2176157-1-skhawaja@google.com>
 <20260203220948.2176157-15-skhawaja@google.com>
 <acROHN5KhJIef0Yd@google.com>
 <acbLdqSEjDNc5kWy@google.com>
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <acbLdqSEjDNc5kWy@google.com>

On Fri, Mar 27, 2026 at 06:25:36PM +0000, Samiullah Khawaja wrote:
>On Wed, Mar 25, 2026 at 09:05:32PM +0000, Pranjal Shrivastava wrote:
>>On Tue, Feb 03, 2026 at 10:09:48PM +0000, Samiullah Khawaja wrote:
>>>Test iommufd preservation by setting up an iommufd and vfio cdev and
>>>preserve it across live update. Test takes VFIO cdev path of a device
>>>bound to vfio-pci driver and binds it to an iommufd being preserved. It
>>>also preserves the vfio cdev so the iommufd state associated with it is
>>>also preserved.
>>>
>>>The restore path is tested by restoring the preserved vfio cdev only.
>>>Test tries to finish the session without restoring iommufd and confirms
>>>that it fails.
>>>
>>>Signed-off-by: Samiullah Khawaja <skhawaja@google.com>
>>>Signed-off-by: YiFei Zhu <zhuyifei@google.com>
>>>---
>>> tools/testing/selftests/iommu/Makefile        |  12 +
>>> .../selftests/iommu/iommufd_liveupdate.c      | 209 ++++++++++++++++++
>>> 2 files changed, 221 insertions(+)
>>> create mode 100644 tools/testing/selftests/iommu/iommufd_liveupdate.c
>>>
>>>+int main(int argc, char *argv[])
>>
>>The iommufd selftest directory heavily utilizes the standard kselftest
>>harness (TEST_F, EXPECT_EQ, ASSERT_EQ), by writing a raw main(), this
>>patch circumvents the standard test reporting structure (like returning 1
>>on argc < 2 instead of ksft_exit_skip(), and returning 0 at the end
>>instead of ksft_exit_pass() etc.). We should rewrite this cleanly
>>following the existing iommufd test infrastructure using TEST_F blocks.
>
>Agreed. Will do.

Thinking about this more, these liveupdate tests are two stage tests.
There is a run before liveupdate and there is a run after liveupdate. I
will have to use the luo_test mechanism here for this test. See example
usage in the kexec_test in the VFIO cdev preservation series:

https://lore.kernel.org/all/20260323235817.1960573-21-dmatlack@google.com
>>
>>>+{
>>>+	int iommufd, cdev_fd, memfd, luo, session, ret;
>>>+	const int token = 0x123456;
>>>+	const int cdev_token = 0x654321;
>>>+	const int hwpt_token = 0x789012;
>>>+	const int memfd_token = 0x890123;
>>
>>Shouldn't these be u64? Defining them as signed int-s undermines that
>>contract?
>
>Agreed. Will update.
>>
>>>+
>>>+	if (argc < 2) {
>>>+		printf("Usage: ./iommufd_liveupdate <vfio_cdev_path>\n");
>>>+		return 1;
>>>+	}
>>>+
>>>+	luo = luo_open_device();
>>>+	ksft_assert(luo > 0);
>>>+
>>>+	session = luo_retrieve_session(luo, "iommufd-test");
>>
>>[ ---- >8 ---- ]
>>
>>Thanks,
>>Praan
>
>Thanks,
>Sami
