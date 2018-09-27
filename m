From: lijiang <lijiang-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 3/4 v7] amd_iommu: remap the device table of IOMMU with
	the memory encryption mask for kdump
Date: Thu, 27 Sep 2018 10:40:49 +0800
Message-ID: <bc9973a2-d3d3-19c2-11ab-3299ad2105c9@redhat.com>
References: <20180907081805.368-1-lijiang@redhat.com>
	<20180907081805.368-4-lijiang@redhat.com>
	<20180925120442.wmh6fjpdghxjyvio@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20180925120442.wmh6fjpdghxjyvio-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: Joerg Roedel <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: thomas.lendacky-5C7GfCeVMHo@public.gmane.org, kexec-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, mingo-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, ebiederm-aS9lmoZGLiVWk0Htik3J/w@public.gmane.org, hpa-YMNOUZJC4hwAvxtiuMwx3w@public.gmane.org, tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org, dyoung-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
List-Id: iommu@lists.linux-foundation.org

5ZyoIDIwMTjlubQwOeaciDI15pelIDIwOjA0LCBKb2VyZyBSb2VkZWwg5YaZ6YGTOgo+IE9uIEZy
aSwgU2VwIDA3LCAyMDE4IGF0IDA0OjE4OjA0UE0gKzA4MDAsIExpYW5ibyBKaWFuZyB3cm90ZToK
Pj4gSW4ga2R1bXAga2VybmVsLCBpdCB3aWxsIGNvcHkgdGhlIGRldmljZSB0YWJsZSBvZiBJT01N
VSBmcm9tIHRoZSBvbGQgZGV2aWNlCj4+IHRhYmxlLCB3aGljaCBpcyBlbmNyeXB0ZWQgd2hlbiBT
TUUgaXMgZW5hYmxlZCBpbiB0aGUgZmlyc3Qga2VybmVsLiBTbyB3ZQo+PiBoYXZlIHRvIHJlbWFw
IHRoZSBvbGQgZGV2aWNlIHRhYmxlIHdpdGggdGhlIG1lbW9yeSBlbmNyeXB0aW9uIG1hc2suCj4+
Cj4+IFNpZ25lZC1vZmYtYnk6IExpYW5ibyBKaWFuZyA8bGlqaWFuZ0ByZWRoYXQuY29tPgo+IAo+
IFBsZWFzZSBjaGFuZ2UgdGhlIHN1YmplY3QgdG86Cj4gCj4gCWlvbW11L2FtZDogUmVtYXAgdGhl
IGRldmljZSB0YWJsZSBvZiBJT01NVSB3aXRoIHRoZSBtZW1vcnkgZW5jcnlwdGlvbiBtYXNrIGZv
ciBrZHVtcAo+IAo+IFdpdGggdGhhdCB5b3UgY2FuIGFkZCBteToKPiAKPiBBY2tlZC1ieTogSm9l
cmcgUm9lZGVsIDxqcm9lZGVsQHN1c2UuZGU+Cj4gCgpUaGFuayB5b3UsIEpvZXJnLgpTb3JyeSBm
b3IgbXkgbGF0ZSByZXBseS4gSSB3aWxsIGNoYW5nZSB0aGUgc3ViamVjdCBhbmQgcmVzZW5kIHRo
aXMgcGF0Y2guCgpUaGFua3MuCkxpYW5ibwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwppb21tdSBtYWlsaW5nIGxpc3QKaW9tbXVAbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vaW9tbXU=
