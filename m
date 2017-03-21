From: "'joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org'" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
Subject: Re: amd-iommu: can't boot with amdgpu, AMD-Vi: Completion-Wait loop
 timed out
Date: Tue, 21 Mar 2017 17:10:57 +0100
Message-ID: <20170321161056.GE29659@8bytes.org>
References: <CAD8Lp457TE1CnJ-DHnB6NB2LWxgA5K5K57Q6L7XcSHeYNpvARQ@mail.gmail.com>
 <CY4PR12MB16533C83151D6FCFC11ED457F7250@CY4PR12MB1653.namprd12.prod.outlook.com>
 <CAD8Lp47zjJvqxY3TMMAhjz3OnLR52CtsQh_PQFPmsEW-xHfDwg@mail.gmail.com>
 <CADnq5_Oyfm-BzU9YV_QLjm6HxtMwnJcFkfYtjmCWpuah35TFvA@mail.gmail.com>
 <20170321155725.GD29659@8bytes.org>
 <BN6PR12MB16526DD4A3B60DB4E20B9907F73D0@BN6PR12MB1652.namprd12.prod.outlook.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Return-path: <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <BN6PR12MB16526DD4A3B60DB4E20B9907F73D0-/b2+HYfkarQqUD6E6FAiowdYzm3356FpvxpqHgZTriW3zl9H0oFU5g@public.gmane.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/amd-gfx>
List-Post: <mailto:amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Help: <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/amd-gfx>,
 <mailto:amd-gfx-request-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org?subject=subscribe>
Errors-To: amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org
Sender: "amd-gfx" <amd-gfx-bounces-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
To: "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, "Nath, Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "Suthikulpanit, Suravee" <Suravee.Suthikulpanit-5C7GfCeVMHo@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

T24gVHVlLCBNYXIgMjEsIDIwMTcgYXQgMDQ6MDE6NTNQTSArMDAwMCwgRGV1Y2hlciwgQWxleGFu
ZGVyIHdyb3RlOgo+IEl0IHNlZW1zIHRvIG9ubHkgYWZmZWN0IFN0b25leSBzeXN0ZW1zLCBidXQg
bm90IG90aGVycyAoQ2Fycml6bywKPiBCcmlzdG9sLCBldGMuKS4gIE1heWJlIHdlIGNvdWxkIGp1
c3QgZGlzYWJsZSBpdCBvbiBTdG9uZXkgdW50aWwgd2UKPiByb290IGNhdXNlIGl0LgoKQ29tcGxl
dGlvbi13YWl0IGxvb3AgdGltZW91dHMgaW5kaWNhdGUgc29tZXRoaW5nIGlzIHNlcmlvdXNseSB3
cm9uZy4gSG93CmNhbiBJIGRldGVjdCB3aGV0aGVyIEkgYW0gcnVubmluZyBvbiBhICdTdG9uZXkn
IHN5c3RlbT8KCk90aGVyIHF1ZXN0aW9uLCBhIHNob3QgaW50byB0aGUgZGFyaywgZG9lcyB0aGUg
R1BVIG9uIHRoZXNlIHN5c3RlbXMgaGF2ZQpBVFM/IFByb2JhYmx5IHllcywgYXMgdGhleSBhcmUg
bGlrZWx5IEhTQSBjb21wYXRpYmxlLgoKCglKb2VyZwoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KYW1kLWdmeCBtYWlsaW5nIGxpc3QKYW1kLWdmeEBsaXN0
cy5mcmVlZGVza3RvcC5vcmcKaHR0cHM6Ly9saXN0cy5mcmVlZGVza3RvcC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9hbWQtZ2Z4Cg==
