From: Joseph Salisbury <joseph.salisbury-Z7WLFzj8eWMS+FvcfC7Uqw@public.gmane.org>
Subject: iommu/amd: flush IOTLB for specific domains only (v2)
Date: Mon, 14 May 2018 15:46:50 -0400
Message-ID: <44f4f22d-c0f4-a6c8-5521-1f532a60c3fe@canonical.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: arindam.nath-5C7GfCeVMHo@public.gmane.org
Cc: John.Bridgman-5C7GfCeVMHo@public.gmane.org, amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org, drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, michel-otUistvHUpPR7s880joybQ@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, stein12c-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, alexander.deucher-5C7GfCeVMHo@public.gmane.org, "1747463-T8XWwAfLipRB/Vz2p19nDaxOck334EZe@public.gmane.org" <1747463-T8XWwAfLipRB/Vz2p19nDaxOck334EZe@public.gmane.org>, linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org, Felix.Kuehling-5C7GfCeVMHo@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

SGVsbG8gQXJpbmRhbSwKClRoZXJlIGlzIGEgYnVnIHJlcG9ydFswXSB0aGF0IHlvdSBjcmVhdGVk
IGEgcGF0Y2hbMV0gZm9yIGEgd2hpbGUgYmFjay7CoApIb3dldmVyLCB0aGUgcGF0Y2ggbmV2ZXIg
bGFuZGVkIGluIG1haW5saW5lLsKgIFRoZXJlIGlzIGEgYnVnIHJlcG9ydGVyIGluClVidW50dVsy
XSB0aGF0IGlzIGFmZmVjdGVkIGJ5IHRoaXMgYnVnIGFuZCBpcyB3aWxsaW5nIHRvIHRlc3QgdGhl
CnBhdGNoLsKgIEkgYXR0ZW1wdGVkIHRvIGJ1aWxkIGEgdGVzdCBrZXJuZWwgd2l0aCB0aGUgcGF0
Y2gsIGJ1dCBpdCBkb2VzCm5vdCBhcHBseSB0byBjdXJyZW50bHkgbWFpbmxpbmUgY2xlYW5seS7C
oCBEbyB5b3Ugc3RpbGwgdGhpbmsgdGhpcyBwYXRjaAptYXkgcmVzb2x2ZSB0aGlzIGJ1Zz/CoCBJ
ZiBzbywgaXMgdGhlcmUgYSB2ZXJzaW9uIG9mIHlvdXIgcGF0Y2ggYXZhaWxhYmxlCnRoYXQgd2ls
bCBhcHBseSB0byBjdXJyZW50IG1haW5saW5lPwoKVGhhbmtzLAoKSm9lCgpbMF0gaHR0cHM6Ly9i
dWdzLmZyZWVkZXNrdG9wLm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MTAxMDI5ClsxXSBodHRwczovL3Bh
dGNod29yay5mcmVlZGVza3RvcC5vcmcvcGF0Y2gvMTU3MzI3LwpbMl0gaHR0cDovL3BhZC5sdi8x
NzQ3NDYzCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpp
b21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6
Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vaW9tbXU=
