From: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: [PATCH 3/3] irq_remap: fix the 'sub_handle' uninitialized warning
Date: Tue,  8 May 2012 00:08:54 -0700
Message-ID: <1336460934-23592-3-git-send-email-suresh.b.siddha@intel.com>
References: <1336460934-23592-1-git-send-email-suresh.b.siddha@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <1336460934-23592-1-git-send-email-suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
In-Reply-To: <20120508035153.GA30652-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
References: <20120508035153.GA30652-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: mingo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: Suresh Siddha <suresh.b.siddha-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

Rml4IHRoZSB1bmluaXRpYWxpemVkIHdhcm5pbmc6CiAgZHJpdmVycy9pb21tdS9pbnRlbF9pcnFf
cmVtYXBwaW5nLmM6OTg2OjEyOiB3YXJuaW5nOiDigJhzdWJfaGFuZGxl4oCZIG1heSBiZSB1c2Vk
IHVuaW5pdGlhbGl6ZWQgaW4gdGhpcyBmdW5jdGlvbiBbLVd1bmluaXRpYWxpemVkXQoKU2lnbmVk
LW9mZi1ieTogU3VyZXNoIFNpZGRoYSA8c3VyZXNoLmIuc2lkZGhhQGludGVsLmNvbT4KQ2M6IEpv
ZXJnIFJvZWRlbCA8am9lcmcucm9lZGVsQGFtZC5jb20+Ci0tLQogZHJpdmVycy9pb21tdS9pbnRl
bF9pcnFfcmVtYXBwaW5nLmMgfCAgICAyICstCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
cygrKSwgMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L2ludGVsX2ly
cV9yZW1hcHBpbmcuYyBiL2RyaXZlcnMvaW9tbXUvaW50ZWxfaXJxX3JlbWFwcGluZy5jCmluZGV4
IDFjMDI1NWUuLjZkMzQ3MDYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvaW9tbXUvaW50ZWxfaXJxX3Jl
bWFwcGluZy5jCisrKyBiL2RyaXZlcnMvaW9tbXUvaW50ZWxfaXJxX3JlbWFwcGluZy5jCkBAIC05
NjQsNyArOTY0LDcgQEAgc3RhdGljIHZvaWQgaW50ZWxfY29tcG9zZV9tc2lfbXNnKHN0cnVjdCBw
Y2lfZGV2ICpwZGV2LAogewogCXN0cnVjdCBpcnFfY2ZnICpjZmc7CiAJc3RydWN0IGlydGUgaXJ0
ZTsKLQl1MTYgc3ViX2hhbmRsZTsKKwl1MTYgc3ViX2hhbmRsZSA9IDA7CiAJaW50IGlyX2luZGV4
OwogCiAJY2ZnID0gaXJxX2dldF9jaGlwX2RhdGEoaXJxKTsKLS0gCjEuNy42LjUKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1haWxpbmcgbGlz
dAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
