From: "Raj, Ashok" <ashok.raj-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Subject: Re: Does a new booting kernel by "kexec -l" need to copy IR table
	from previous kernel?
Date: Thu, 27 Apr 2017 09:21:12 -0700
Message-ID: <20170427162111.GA7556@linux.intel.com>
References: <E6AF1AFDEA62A94A97508F458CBDD47F6EBEFCC9@SHSMSX101.ccr.corp.intel.com>
	<20170427161238.GD1332@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170427161238.GD1332-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: "joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Zhuo, Qiuxu" <qiuxu.zhuo-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, "jroedel-l3A5Bk7waGM@public.gmane.org" <jroedel-l3A5Bk7waGM@public.gmane.org>, "Luck, Tony" <tony.luck-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

SGkgSm9lcmcsCgpPbiBUaHUsIEFwciAyNywgMjAxNyBhdCAwNjoxMjozOFBNICswMjAwLCBqb3Jv
QDhieXRlcy5vcmcgd3JvdGU6Cj4gT24gVGh1LCBBcHIgMjcsIDIwMTcgYXQgMDM6MzQ6MDZQTSAr
MDAwMCwgWmh1bywgUWl1eHUgd3JvdGU6Cj4gPiBJdCBsb29rcyBsaWtlIHRoZSBwcmludGsgaXMg
bWlzbGVhZGluZyBhbmQgaXTigJlzIG5vdGhpbmcgYWN0dWFsbHkKPiA+IGZhaWxlZCwgYnV0IGp1
c3QgaXQgaXNu4oCZdCBjb3B5aW5nIGlmIHRoZSBuZXcga2VybmVsIGlzIG5vdCBhIGtkdW1wCj4g
PiBrZXJuZWwuCj4gCj4gWWVzLCB0aGF0IGlzIHRydWUuIEJ1dCB0aGUgbWVzc2FnZXMgYXJlIGhh
cm1sZXNzIGFuZCB5b3UgYXJlIHNhZmUgdG8KPiBpZ25vcmUgdGhlbSBpbiB5b3VyIHVzZWNhc2Uu
IFdlIG9ubHkgY2FyZSBhYm91dCB0aGUga2R1bXAgY2FzZSB3aGVuCgpMb29rcyBsaWtlIG1heWJl
IHNhbml0aXppbmcgdGhlIG1lc3NhZ2UgdG8gbWFrZSBpdCBsZXNzIGRpc3R1cmJpbmcgCnNob3Vs
ZCBiZSBlbm91Z2ggOi0pIAoKPiBjb3B5aW5nIHRoZSBvbGQgSVIgYW5kIERNQVIgdGFibGVzIGlu
dG8gdGhlIG5ldyBrZXJuZWwsIGJlY2F1c2UgaW4gdGhlCj4ga2R1bXAgY2FzZSB0aGUgb2xkIGtl
cm5lbCBjcmFzaGVkIGFuZCBsZWZ0IGRldmljZXMgaW4gYW4gdW5kZWZpbmVkCj4gc3RhdGUsIHNv
IHRoYXQgdGhleSBtaWdodCBzdGlsbCBzZW5kIERNQSBhbmQgSVJRIHJlcXVlc3RzIHRvIHRoZSBu
ZXcKPiBrZXJuZWwsIGNvcnJ1cHRpbmcgZGF0YSBvciBjYXVzaW5nIHNwdXJpb3VzL2Jsb2NrZWQg
aXJxcy4gQmxvY2tlZCBJUlFzCj4gb3IgRE1BIHJlcXVlc3RzIG1pZ2h0IGV2ZW4gYnJlYWsgZGV2
aWNlcyBzbyB0aGF0IHRoZSBuZXcga2VybmVsIGNhbid0Cj4gaW5pdGlhbGl6ZSB0aGVtIGFueW1v
cmUuCgpDaGVlcnMsCkFzaG9rCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmlvbW11IG1haWxpbmcgbGlzdAppb21tdUBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby9p
b21tdQ==
