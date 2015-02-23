From: =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle-QFKgK+z4sOrR7s880joybQ@public.gmane.org>
Subject: [PATCH v2 linux-next] iommu: Enable LPAE pagetable on ARM only
Date: Tue, 24 Feb 2015 00:55:21 +0100
Message-ID: <1424735721-32313-1-git-send-email-vincent.stehle@laposte.net>
References: <2868840.GyWYJOzqWH@avalon>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <2868840.GyWYJOzqWH@avalon>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: laurent.pinchart-ryLnwIuWjnjg/C1BVhZhaw@public.gmane.org
Cc: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, =?UTF-8?q?Vincent=20Stehl=C3=A9?= <vincent.stehle-QFKgK+z4sOrR7s880joybQ@public.gmane.org>, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, linux-next-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

TFBBRSBpb21tdSBwYWdlIHRhYmxlIG1ha2VzIHNlbnNlIG9ubHkgZm9yIEFSTSBhcmNoaXRlY3R1
cmUuIEFkZCB0aGUKY29ycmVzcG9uZGluZyBkZXBlbmRlbmN5IGluIEtjb25maWcgKGFuZCBlbmFi
bGUgZm9yIENPTVBJTEVfVEVTVCwgdG9vLCBhcyBwZXIKTGF1cmVudCdzIHN1Z2dlc3Rpb24pLgoK
U2lnbmVkLW9mZi1ieTogVmluY2VudCBTdGVobMOpIDx2aW5jZW50LnN0ZWhsZUBsYXBvc3RlLm5l
dD4KU3VnZ2VzdGVkLWJ5OiBMYXVyZW50IFBpbmNoYXJ0IDxsYXVyZW50LnBpbmNoYXJ0QGlkZWFz
b25ib2FyZC5jb20+CkNjOiBXaWxsIERlYWNvbiA8d2lsbC5kZWFjb25AYXJtLmNvbT4KLS0tCgpD
aGFuZ2VzIHNpbmNlIHYxOgotIEFkZCBjb25kaXRpb24gb24gQ09NUElMRV9URVNUCgogZHJpdmVy
cy9pb21tdS9LY29uZmlnIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRp
ZmYgLS1naXQgYS9kcml2ZXJzL2lvbW11L0tjb25maWcgYi9kcml2ZXJzL2lvbW11L0tjb25maWcK
aW5kZXggYmFhMGQ5Ny4uMjdjZDg4ZCAxMDA2NDQKLS0tIGEvZHJpdmVycy9pb21tdS9LY29uZmln
CisrKyBiL2RyaXZlcnMvaW9tbXUvS2NvbmZpZwpAQCAtMjIsNiArMjIsNyBAQCBjb25maWcgSU9N
TVVfSU9fUEdUQUJMRQogCiBjb25maWcgSU9NTVVfSU9fUEdUQUJMRV9MUEFFCiAJYm9vbCAiQVJN
djcvdjggTG9uZyBEZXNjcmlwdG9yIEZvcm1hdCIKKwlkZXBlbmRzIG9uIEFSTSB8fCBDT01QSUxF
X1RFU1QKIAlzZWxlY3QgSU9NTVVfSU9fUEdUQUJMRQogCWhlbHAKIAkgIEVuYWJsZSBzdXBwb3J0
IGZvciB0aGUgQVJNIGxvbmcgZGVzY3JpcHRvciBwYWdldGFibGUgZm9ybWF0LgotLSAKMi4xLjQK
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmlvbW11IG1h
aWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9pb21tdQ==
