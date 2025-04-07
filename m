Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50AC1233D85;
	Mon,  7 Apr 2025 11:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023918; cv=none; b=GXZC+2PP//mOw9bRu/zd/611Ouvjnb9fpa/MB47X7Obt8ftpL+k82o5ehFcJDVwL7yQeTFXPkTAMUKk3sJxEQngvFMGCIIOOA0IcXTBDNiqmUgRnSUt7XkYj4ch3wK/SeV+qeEFYEKY3DRozyQqXbRzaipMmGhEW8Ar8iDnI69E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023918; c=relaxed/simple;
	bh=nJCcGwyCZuu6B9cg8mEdqiZn0bZFneyhdJXneM3xqYk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:Content-Type:
	 MIME-Version; b=Xb9+90NCrt7qwDUSX7uc1x0/oSKvAKrK6IpDPE69KsfM4yYHt/cTpcKdaYR9+9A3PPWiLQ1EYuXjtTLNdCKdNRd8pGpHz8vIr34odKV8GK3O/Avq4SijQJ1mpDn5WPXb5jSpg6B8Jsps1bFcCj6tadrs9OUVo8QEjcGdk7vb/PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aXI0xH6n; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aXI0xH6n"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5ed1ac116e3so7063113a12.3;
        Mon, 07 Apr 2025 04:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744023913; x=1744628713; darn=lists.linux.dev;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bOXFkEFTB5SlM6cWWhuxa7vVuGMc7ycBvnouqma9E0c=;
        b=aXI0xH6n8FKu05ts7j2hRz36wbz4sI+c3sEmqpv3aVzeeTj6yLCJ+BCxy449yh7M2w
         nj8Xc1BSPTONxmbg/wTOwTVRqUzqZnKWTVLPxAcUMduPclPniFS74seRyaB95YQ0JG2d
         obiUe6zznaK7lQcv4qO5s9xnOziiNcOEXBiAVW7e+9vRGatbjDfnBScIRSGB5i6he1dT
         b9UvZ+J8oJvjp1dcllr1LRrUUZHtdk+GkBHLtpxH7+wRWPdw78ebvfyQoWdvwQINr+BX
         PV9xCPiQ5QycVsC3reOEMDhj9kGxjNYGIhOpC0hXyA0SyDtsYWVxAg3L+nXGVPgbzBl9
         V4JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744023913; x=1744628713;
        h=mime-version:user-agent:content-transfer-encoding:in-reply-to:date
         :cc:to:from:subject:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bOXFkEFTB5SlM6cWWhuxa7vVuGMc7ycBvnouqma9E0c=;
        b=hce3hzEkzTJx+svCvpQrZCEJx9P59D3KqeS2482NKqHKsW8Q6iIAOZCr7iYSBe3wOi
         /feMEebqG0OIv02/HkGLwabCqGwD+p7YmPwi1p1kL5SEl2UgJqcXrmWjSHGNVUery7SK
         BGkdd34YQKRgF+Zh+lf2RLabmA2FKfJKTf5vgJ6OAMYRRmOjqYEuJBN32vHmTlDiXNKU
         DZnnyPq0bEyfochpYNUifVleZ7vkWnmAmZrCf3cvVytzNM0LxOEEGy3vx4uHBizd4poH
         sgbsy8UFp9GWmmjItq0vT49VufHlHAflrL/MRIHxMaGGRqFXndv/vpeu03Usv/hcOxpN
         yWIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWub7KvwCIJ897EcJNM5oa20u9tR+UCC+U7yAlOCS12xV8DgAUDBbHNmMI9Ygea0svJBH5LWa1G1dnsfw==@lists.linux.dev, AJvYcCXYTbW/d1q2c3TZB/YxmhACQZg2Er0yw0whcGL895S5ELk63w0zIdrEJVQZXf/bpdBxk4Q7yw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxPxcKf/LQCK7S3detYDzSdQZwg2UrM19iUJkeXUr90C+80i+Uc
	CnqKGmdIKq45oVXFQkcCCIqYD69MAcvdWg4Qz/pjaOlW4pFEy0NH
X-Gm-Gg: ASbGncvMfKC2lUjQ4JmP7zfcq+20+QUb3JXtVLAtuHjLwLVZTmI8Grv0wt6Y3HJcmjy
	MahTXF/1BUqtUm9op691VRx1i7bYBFoJPpy74AV5n3FyfTCCd4dU5TQjYX8Q6FN756dvktJP7+A
	okZD6i8/X1uo6OoR8ZCXS7HyPb2C6abOeYL9q79zdp3OvS7aB2PBXxnAwWzrB1YOua+G7bg7MT3
	tQkYb6ziyPo3zuI7MlaPNW+UeFKWyojcg9WmnhGgK7wPwr13C25EjiBSZuXBpxixy64om/KGVvx
	trQXVLABjuSAp+b1HaZq7ZY0jD1YZb3nzFcH8MQH53p1B2YAx1zPhtzPT0n16mM9MYgo34Md/id
	iZ0bW5To0vjgrBrMZySSI2xtHew==
X-Google-Smtp-Source: AGHT+IHEdeZlXLBPLb2AZowh6EoNtmvcb1ERqK3ljQe07QWdq2HbAjNeGOzM9Iopbn8UOdCKiJvXBg==
X-Received: by 2002:a05:6402:428c:b0:5f0:d853:dfec with SMTP id 4fb4d7f45d1cf-5f0d853e065mr7827782a12.13.1744023913379;
        Mon, 07 Apr 2025 04:05:13 -0700 (PDT)
Received: from ?IPv6:2001:b07:5d29:f42d:b211:eeef:5b8c:dd2f? ([2001:b07:5d29:f42d:b211:eeef:5b8c:dd2f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f087eedf61sm6359409a12.32.2025.04.07.04.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 04:05:13 -0700 (PDT)
Message-ID: <dca6b4a3ec0c19588221205baeb55d1a424e9af6.camel@gmail.com>
Subject: Re: [RFC PATCH v2 18/22] coco/sev-guest: Implement the guest
 support for SEV TIO
From: Francesco Lavra <francescolavra.fl@gmail.com>
To: aik@amd.com
Cc: Jonathan.Cameron@huawei.com, aneesh.kumar@kernel.org,
 ashish.kalra@amd.com,  baolu.lu@linux.intel.com, bhelgaas@google.com,
 dan.j.williams@intel.com,  dionnaglaze@google.com, hch@lst.de,
 iommu@lists.linux.dev, jgg@ziepe.ca,  joao.m.martins@oracle.com,
 joro@8bytes.org, kevin.tian@intel.com,  kvm@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-coco@lists.linux.dev, 
 linux-crypto@vger.kernel.org, linux-pci@vger.kernel.org, lukas@wunner.de, 
 michael.roth@amd.com, nicolinc@nvidia.com, nikunj@amd.com,
 pbonzini@redhat.com,  robin.murphy@arm.com, seanjc@google.com,
 steven.sistare@oracle.com,  suravee.suthikulpanit@amd.com,
 suzuki.poulose@arm.com, thomas.lendacky@amd.com,  vasant.hegde@amd.com,
 x86@kernel.org, yi.l.liu@intel.com, yilun.xu@linux.intel.com, 
 zhiw@nvidia.com
Date: Mon, 07 Apr 2025 13:05:10 +0200
In-Reply-To: <20250218111017.491719-19-aik@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

On 2025-02-18 at 11:10, Alexey Kardashevskiy wrote:
>=20
> +static int handle_tio_guest_request(struct snp_guest_dev *snp_dev,
> u8 type,
> +				   void *req_buf, size_t req_sz,
> void *resp_buf, u32 resp_sz,
> +				   void *pt, u64 *npages, u64 *bdfn,
> u64 *param, u64 *fw_err)
> +{
> +	struct snp_msg_desc *mdesc =3D snp_dev->msg_desc;
> +	struct snp_guest_req req =3D {
> +		.msg_version =3D TIO_MESSAGE_VERSION,
> +	};
> +	u64 exitinfo2 =3D 0;
> +	int ret;
> +
> +	req.msg_type =3D type;
> +	req.vmpck_id =3D mdesc->vmpck_id;
> +	req.req_buf =3D req_buf;
> +	req.req_sz =3D req_sz;
> +	req.resp_buf =3D resp_buf;
> +	req.resp_sz =3D resp_sz;
> +	req.exit_code =3D SVM_VMGEXIT_SEV_TIO_GUEST_REQUEST;
> +
> +	req.input.guest_rid =3D 0;
> +	req.input.param =3D 0;
> +
> +	if (pt && npages) {
> +		req.data =3D pt;
> +		req.input.data_npages =3D *npages;
> +	}
> +	if (bdfn)
> +		req.input.guest_rid =3D *bdfn;
> +	if (param)
> +		req.input.param =3D *param;
> +
> +	ret =3D snp_send_guest_request(mdesc, &req, &exitinfo2);
> +
> +	if (param)
> +		*param =3D req.input.param;
> +
> +	*fw_err =3D exitinfo2;
> +
> +	return ret;

The logic to update *npages is missing.

>=20
> +}
> +
> +static int guest_request_tio_data(struct snp_guest_dev *snp_dev, u8
> type,
> +				   void *req_buf, size_t req_sz,
> void *resp_buf, u32 resp_sz,
> +				   u64 bdfn, enum tsm_tdisp_state
> *state,
> +				   struct tsm_blob **certs, struct
> tsm_blob **meas,
> +				   struct tsm_blob **report, u64
> *fw_err)
> +{
> +	u64 npages =3D SZ_32K >> PAGE_SHIFT, c1, param =3D 0;
> +	struct tio_blob_table_entry *pt;
> +	int rc;
> +
> +	pt =3D snp_alloc_shared_pages(npages << PAGE_SHIFT);
> +	if (!pt)
> +		return -ENOMEM;
> +
> +	c1 =3D npages;
> +	rc =3D handle_tio_guest_request(snp_dev, type, req_buf,
> req_sz, resp_buf, resp_sz,
> +				      pt, &c1, &bdfn, state ? &param
> : NULL, fw_err);
> +
> +	if (c1 > SZ_32K) {

c1 is supposed to be a number of pages, not a number of bytes.

> +static int tio_tdi_status(struct tsm_tdi *tdi, struct snp_guest_dev
> *snp_dev,
> +			  struct tsm_tdi_status *ts)
> +{
> +	struct snp_msg_desc *mdesc =3D snp_dev->msg_desc;
> +	size_t resp_len =3D sizeof(struct tio_msg_tdi_info_rsp) +
> mdesc->ctx->authsize;
> +	struct tio_msg_tdi_info_rsp *rsp =3D kzalloc(resp_len,
> GFP_KERNEL);
> +	struct tio_msg_tdi_info_req req =3D {
> +		.guest_device_id =3D pci_dev_id(tdi_to_pci_dev(tdi)),
> +	};
> +	u64 fw_err =3D 0;
> +	int rc;
> +	enum tsm_tdisp_state state =3D 0;
> +
> +	dev_notice(&tdi->dev, "TDI info");
> +	if (!rsp)
> +		return -ENOMEM;
> +
> +	rc =3D guest_request_tio_data(snp_dev, TIO_MSG_TDI_INFO_REQ,
> &req,
> +				     sizeof(req), rsp, resp_len,
> +				   =20
> pci_dev_id(tdi_to_pci_dev(tdi)), &state,
> +				     &tdi->tdev->certs, &tdi->tdev-
> >meas,
> +				     &tdi->report, &fw_err);
> +	if (rc)
> +		goto free_exit;
> +
> +	ts->meas_digest_valid =3D rsp->meas_digest_valid;
> +	ts->meas_digest_fresh =3D rsp->meas_digest_fresh;
> +	ts->no_fw_update =3D rsp->no_fw_update;
> +	ts->cache_line_size =3D rsp->cache_line_size =3D=3D 0 ? 64 : 128;
> +	ts->lock_msix =3D rsp->lock_msix;
> +	ts->bind_p2p =3D rsp->bind_p2p;
> +	ts->all_request_redirect =3D rsp->all_request_redirect;
> +#define __ALGO(x, n, y) \
> +	((((x) & (0xFFUL << (n))) =3D=3D TIO_SPDM_ALGOS_##y) ? \
> +	 (1ULL << TSM_SPDM_ALGOS_##y) : 0)
> +	ts->spdm_algos =3D
> +		__ALGO(rsp->spdm_algos, 0, DHE_SECP256R1) |
> +		__ALGO(rsp->spdm_algos, 0, DHE_SECP384R1) |
> +		__ALGO(rsp->spdm_algos, 8, AEAD_AES_128_GCM) |
> +		__ALGO(rsp->spdm_algos, 8, AEAD_AES_256_GCM) |
> +		__ALGO(rsp->spdm_algos, 16,
> ASYM_TPM_ALG_RSASSA_3072) |
> +		__ALGO(rsp->spdm_algos, 16,
> ASYM_TPM_ALG_ECDSA_ECC_NIST_P256) |
> +		__ALGO(rsp->spdm_algos, 16,
> ASYM_TPM_ALG_ECDSA_ECC_NIST_P384) |
> +		__ALGO(rsp->spdm_algos, 24, HASH_TPM_ALG_SHA_256) |
> +		__ALGO(rsp->spdm_algos, 24, HASH_TPM_ALG_SHA_384) |
> +		__ALGO(rsp->spdm_algos, 32,
> KEY_SCHED_SPDM_KEY_SCHEDULE);
> +#undef __ALGO
> +	memcpy(ts->certs_digest, rsp->certs_digest, sizeof(ts-
> >certs_digest));
> +	memcpy(ts->meas_digest, rsp->meas_digest, sizeof(ts-
> >meas_digest));
> +	memcpy(ts->interface_report_digest, rsp-
> >interface_report_digest,
> +	       sizeof(ts->interface_report_digest));
> +	ts->intf_report_counter =3D rsp->tdi_report_count;
> +
> +	ts->valid =3D true;
> +	ts->state =3D state;
> +	/* The response buffer contains the sensitive data,
> explicitly clear it. */
> +free_exit:
> +	memzero_explicit(&rsp, sizeof(resp_len));

The first argument should be rsp, not &rsp. This issue is also present
in the other memzero_explicit() calls in this patch.

> +static int sev_guest_tdi_validate(struct tsm_tdi *tdi, unsigned int
> featuremask,
> +				  bool invalidate, void
> *private_data)
> +{
> +	struct snp_guest_dev *snp_dev =3D private_data;
> +	struct tsm_tdi_status ts =3D { 0 };
> +	int ret;
> +
> +	if (!tdi->report) {
> +		ret =3D tio_tdi_status(tdi, snp_dev, &ts);
> +
> +		if (ret || !tdi->report) {
> +			dev_err(&tdi->dev, "No report available,
> ret=3D%d", ret);
> +			if (!ret && tdi->report)

This cannot happen, I think you meant (!ret && !tdi->report)
>=20
