Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FEC29A312
	for <iommu@lists.linux.dev>; Fri, 17 Oct 2025 17:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760722134; cv=none; b=JNiehqX4zFI2femKCfJcv+gRdBKDHyMbRpy9dSTr02H8f9QFbBczdzFspxGjVTDGthqG5wc3ZFEkAFbxJdzJnNR7355u0zYwLZTJbNZOFu7az12uUWYhZhYPxQZtWjAcUwkg4mapaQIyfcCJ7zr+DBQ/k6CB7VQekZpZMiLXG2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760722134; c=relaxed/simple;
	bh=SvKQ/17WNYzFeQtnqjZcX24DdJXumkbVdSqHG56jAyY=;
	h=Content-Type:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To; b=L/yYgzATsZBaX6502FLkr3cMlC+kjDMPZ72+GzRF6FkMMGawRZZNOGGqnnRCO+76iBPUikyyorAHt8Wj+3Hm3SLn+z4QwoguDpJQ2JSG11r6E0X/GOYeuglUq4qE5w7iW7h3/q6twWQfqUjJ91h/EGIcS4ahRTF9kDDzSkdJ0ec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Jd23N6Wq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Jd23N6Wq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1760722132; x=1792258132;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to;
  bh=SvKQ/17WNYzFeQtnqjZcX24DdJXumkbVdSqHG56jAyY=;
  b=Jd23N6WqU0N8RIJS6WPrjdd0Rr6Ln+GYHMV4kvtye1pjEGHgDpgKpsZf
   feLrVIiNlPuNwzakOhEkqBMdC7juy0n4Ng47sDwVJ5kyZupCqOgjrFnqN
   EjUkxPGobN6FxXBjywcD1SVBrSag3sBOzfNssI8u5OkHA+JgsR+eX3Pxl
   2n/mT+dIVVi6MCK67OB9UEzZZomilnPRwHm5dERyWcyI4jocCJcgVgemk
   kxWy/qM8vGL62/BCbgY6ysgv11Z4pe2b9ZZuRpInf3pcQNqqm338d3u5Y
   sawMxTE4DVithpsmZwpZmp0xpsEvyRjQzEdckWTPWjpp/9N+68fr4nxGH
   w==;
X-CSE-ConnectionGUID: A3azJzixRu21yhQwWfoGUQ==
X-CSE-MsgGUID: MjFVVbNoRXKBgUXjhPBDmw==
X-IronPort-AV: E=McAfee;i="6800,10657,11585"; a="80383763"
X-IronPort-AV: E=Sophos;i="6.19,237,1754982000"; 
   d="scan'208";a="80383763"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 10:28:51 -0700
X-CSE-ConnectionGUID: 4dIFaWtDQWWjFKptpRyRCg==
X-CSE-MsgGUID: uUiANFI5Q9uSKDD5Q5s3wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,237,1754982000"; 
   d="scan'208";a="186807165"
Received: from spandruv-mobl4.amr.corp.intel.com (HELO [10.125.108.40]) ([10.125.108.40])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2025 10:28:51 -0700
Content-Type: multipart/mixed; boundary="------------GwXy19Mun0gf93RLFz0jKSy7"
Message-ID: <c3eee56a-7fe3-454c-878f-cff37467fb7e@intel.com>
Date: Fri, 17 Oct 2025 10:28:50 -0700
Precedence: bulk
X-Mailing-List: iommu@lists.linux.dev
List-Id: <iommu.lists.linux.dev>
List-Subscribe: <mailto:iommu+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:iommu+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/7] Fix stale IOTLB entries for kernel address space
To: Jason Gunthorpe <jgg@nvidia.com>, Baolu Lu <baolu.lu@linux.intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Joerg Roedel
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Kevin Tian <kevin.tian@intel.com>,
 Jann Horn <jannh@google.com>, Vasant Hegde <vasant.hegde@amd.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Alistair Popple <apopple@nvidia.com>,
 Peter Zijlstra <peterz@infradead.org>, Uladzislau Rezki <urezki@gmail.com>,
 Jean-Philippe Brucker <jean-philippe@linaro.org>,
 Andy Lutomirski <luto@kernel.org>, Yi Lai <yi1.lai@intel.com>,
 David Hildenbrand <david@redhat.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R . Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 iommu@lists.linux.dev, security@kernel.org, x86@kernel.org,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 "Jiang, Dave" <dave.jiang@intel.com>,
 Vinicius Costa Gomes <vinicius.gomes@intel.com>
References: <20251014130437.1090448-1-baolu.lu@linux.intel.com>
 <20251014174339.c7b7d2cfb9f60d225e4fe5ec@linux-foundation.org>
 <6b187b20-6017-4f85-93ac-529d5df33aa2@linux.intel.com>
 <ecee3200-c8e2-47ec-a219-c88e8e905b32@intel.com>
 <11cad2be-9402-4d45-8d2b-c92d8962edfc@linux.intel.com>
 <20251017140101.GM3901471@nvidia.com>
From: Dave Hansen <dave.hansen@intel.com>
Content-Language: en-US
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20251017140101.GM3901471@nvidia.com>

This is a multi-part message in MIME format.
--------------GwXy19Mun0gf93RLFz0jKSy7
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/17/25 07:01, Jason Gunthorpe wrote:
>>> The other alternative is to have arch_vmap_pmd_supported() return false
>>> when SVA is active, or maybe when it's supported on the platform.
>>>
>>> Either of those are 10-ish lines of code and easy to backport.
>> Hi iommu folks, any insights on this?
> IDK, the only SVA user on x86 I know is IDXD, so if you do the above
> plan you break IDXD in all stable kernels. Doesn't sound OK?

Vinicius, any thoughts on this?

I'm thinking that even messing with arch_vmap_pmd_supported() would be
suboptimal. The easiest thing is to just stick the attached patch in
stable kernels and disable SVA at compile time.

There just aren't enough SVA users out in the wild to justify more
complexity than this.
--------------GwXy19Mun0gf93RLFz0jKSy7
Content-Type: text/x-patch; charset=UTF-8; name="svm.patch"
Content-Disposition: attachment; filename="svm.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2FyY2gveDg2L2VudHJ5L3ZzeXNjYWxsL3ZzeXNjYWxsXzY0LmMgYi9h
cmNoL3g4Ni9lbnRyeS92c3lzY2FsbC92c3lzY2FsbF82NC5jCmluZGV4IGM5MTAzYTZmYTA2
ZS4uMGIwZTAyODM5OTRmIDEwMDY0NAotLS0gYS9hcmNoL3g4Ni9lbnRyeS92c3lzY2FsbC92
c3lzY2FsbF82NC5jCisrKyBiL2FyY2gveDg2L2VudHJ5L3ZzeXNjYWxsL3ZzeXNjYWxsXzY0
LmMKQEAgLTEyNCw3ICsxMjQsOCBAQCBib29sIGVtdWxhdGVfdnN5c2NhbGwodW5zaWduZWQg
bG9uZyBlcnJvcl9jb2RlLAogCWlmICgoZXJyb3JfY29kZSAmIChYODZfUEZfV1JJVEUgfCBY
ODZfUEZfVVNFUikpICE9IFg4Nl9QRl9VU0VSKQogCQlyZXR1cm4gZmFsc2U7CiAKLQlpZiAo
IShlcnJvcl9jb2RlICYgWDg2X1BGX0lOU1RSKSkgeworCS8qIEF2b2lkIGVtdWxhdGlvbiB1
bmxlc3MgdXNlcnNwYWNlIHdhcyBleGVjdXRpbmcgZnJvbSB2c3lzY2FsbCBwYWdlOiAqLwor
CWlmIChhZGRyZXNzICE9IHJlZ3MtPmlwKSB7CiAJCS8qIEZhaWxlZCB2c3lzY2FsbCByZWFk
ICovCiAJCWlmICh2c3lzY2FsbF9tb2RlID09IEVNVUxBVEUpCiAJCQlyZXR1cm4gZmFsc2U7
CkBAIC0xMzYsMTMgKzEzNywxNiBAQCBib29sIGVtdWxhdGVfdnN5c2NhbGwodW5zaWduZWQg
bG9uZyBlcnJvcl9jb2RlLAogCQlyZXR1cm4gZmFsc2U7CiAJfQogCisKKwkvKiBYODZfUEZf
SU5TVFIgaXMgb25seSBzZXQgd2hlbiBOWCBpcyBzdXBwb3J0ZWQ6ICovCisJaWYgKGNwdV9m
ZWF0dXJlX2VuYWJsZWQoWDg2X0ZFQVRVUkVfTlgpKQorCQlXQVJOX09OX09OQ0UoIShlcnJv
cl9jb2RlICYgWDg2X1BGX0lOU1RSKSk7CisKIAkvKgogCSAqIE5vIHBvaW50IGluIGNoZWNr
aW5nIENTIC0tIHRoZSBvbmx5IHdheSB0byBnZXQgaGVyZSBpcyBhIHVzZXIgbW9kZQogCSAq
IHRyYXAgdG8gYSBoaWdoIGFkZHJlc3MsIHdoaWNoIG1lYW5zIHRoYXQgd2UncmUgaW4gNjQt
Yml0IHVzZXIgY29kZS4KIAkgKi8KIAotCVdBUk5fT05fT05DRShhZGRyZXNzICE9IHJlZ3Mt
PmlwKTsKLQogCWlmICh2c3lzY2FsbF9tb2RlID09IE5PTkUpIHsKIAkJd2Fybl9iYWRfdnN5
c2NhbGwoS0VSTl9JTkZPLCByZWdzLAogCQkJCSAgInZzeXNjYWxsIGF0dGVtcHRlZCB3aXRo
IHZzeXNjYWxsPW5vbmUiKTsKZGlmZiAtLWdpdCBhL2FyY2gveDg2L21tL3RsYi5jIGIvYXJj
aC94ODYvbW0vdGxiLmMKaW5kZXggMzlmODAxMTFlNmYxLi5lM2NlOWIwYjI0NDcgMTAwNjQ0
Ci0tLSBhL2FyY2gveDg2L21tL3RsYi5jCisrKyBiL2FyY2gveDg2L21tL3RsYi5jCkBAIC02
NjUsNiArNjY1LDcgQEAgc3RhdGljIHVuc2lnbmVkIGxvbmcgbW1fbWFuZ2xlX3RpZl9zcGVj
X2JpdHMoc3RydWN0IHRhc2tfc3RydWN0ICpuZXh0KQogc3RhdGljIHZvaWQgY29uZF9taXRp
Z2F0aW9uKHN0cnVjdCB0YXNrX3N0cnVjdCAqbmV4dCkKIHsKIAl1bnNpZ25lZCBsb25nIHBy
ZXZfbW0sIG5leHRfbW07CisJYm9vbCB1c2Vyc3BhY2VfbmVlZHNfaWJwYiA9IGZhbHNlOwog
CiAJaWYgKCFuZXh0IHx8ICFuZXh0LT5tbSkKIAkJcmV0dXJuOwpAQCAtNzIyLDcgKzcyMyw3
IEBAIHN0YXRpYyB2b2lkIGNvbmRfbWl0aWdhdGlvbihzdHJ1Y3QgdGFza19zdHJ1Y3QgKm5l
eHQpCiAJCSAqLwogCQlpZiAobmV4dF9tbSAhPSBwcmV2X21tICYmCiAJCSAgICAobmV4dF9t
bSB8IHByZXZfbW0pICYgTEFTVF9VU0VSX01NX0lCUEIpCi0JCQlpbmRpcmVjdF9icmFuY2hf
cHJlZGljdGlvbl9iYXJyaWVyKCk7CisJCQl1c2Vyc3BhY2VfbmVlZHNfaWJwYiA9IHRydWU7
CiAJfQogCiAJaWYgKHN0YXRpY19icmFuY2hfdW5saWtlbHkoJnN3aXRjaF9tbV9hbHdheXNf
aWJwYikpIHsKQEAgLTczMiw5ICs3MzMsMTEgQEAgc3RhdGljIHZvaWQgY29uZF9taXRpZ2F0
aW9uKHN0cnVjdCB0YXNrX3N0cnVjdCAqbmV4dCkKIAkJICogbGFzdCBvbiB0aGlzIENQVS4K
IAkJICovCiAJCWlmICgocHJldl9tbSAmIH5MQVNUX1VTRVJfTU1fU1BFQ19NQVNLKSAhPSAo
dW5zaWduZWQgbG9uZyluZXh0LT5tbSkKLQkJCWluZGlyZWN0X2JyYW5jaF9wcmVkaWN0aW9u
X2JhcnJpZXIoKTsKKwkJCXVzZXJzcGFjZV9uZWVkc19pYnBiID0gdHJ1ZTsKIAl9CiAKKwl0
aGlzX2NwdV93cml0ZSh4ODZfaWJwYl9leGl0X3RvX3VzZXIsIHVzZXJzcGFjZV9uZWVkc19p
YnBiKTsKKwogCWlmIChzdGF0aWNfYnJhbmNoX3VubGlrZWx5KCZzd2l0Y2hfbW1fY29uZF9s
MWRfZmx1c2gpKSB7CiAJCS8qCiAJCSAqIEZsdXNoIEwxRCB3aGVuIHRoZSBvdXRnb2luZyB0
YXNrIHJlcXVlc3RlZCBpdCBhbmQvb3IKZGlmZiAtLWdpdCBhL2RyaXZlcnMvaW9tbXUvaW50
ZWwvS2NvbmZpZyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvS2NvbmZpZwppbmRleCBmMmY1Mzhj
NzA2NTAuLmE1ZDY2YmZkOWU1MCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC9L
Y29uZmlnCisrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWwvS2NvbmZpZwpAQCAtNDgsNyArNDgs
MTAgQEAgY29uZmlnIElOVEVMX0lPTU1VX0RFQlVHRlMKIAogY29uZmlnIElOVEVMX0lPTU1V
X1NWTQogCWJvb2wgIlN1cHBvcnQgZm9yIFNoYXJlZCBWaXJ0dWFsIE1lbW9yeSB3aXRoIElu
dGVsIElPTU1VIgotCWRlcGVuZHMgb24gWDg2XzY0CisJIyBUaGUga2VybmVsIGRvZXMgbm90
IGludmFsaWRhdGUgSU9UTEIgZW50cmllcyB3aGVuIGZyZWVpbmcKKwkjIGtlcm5lbCBwYWdl
IHRhYmxlcy4gVGhpcyBjYW4gbGVhZCB0byBJT01NVXMgd2Fsa2luZyAoYW5kCisJIyB3cml0
aW5nIHRvKSBDUFUgcGFnZSB0YWJsZXMgYWZ0ZXIgdGhleSBhcmUgZnJlZWQuCisJZGVwZW5k
cyBvbiBCUk9LRU4KIAlzZWxlY3QgTU1VX05PVElGSUVSCiAJc2VsZWN0IElPTU1VX1NWQQog
CWhlbHAK

--------------GwXy19Mun0gf93RLFz0jKSy7--
