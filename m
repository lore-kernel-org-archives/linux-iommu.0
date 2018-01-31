From: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig-5C7GfCeVMHo@public.gmane.org>
Subject: Re: [PATCH 11/13] drm/amdgpu: add DRM_AMDGPU_ATC config option
Date: Wed, 31 Jan 2018 14:04:17 +0100
Message-ID: <6b19483a-79f3-e5e0-307f-ead73b4e2b7a@amd.com>
References: <20180126201326.8829-1-christian.koenig@amd.com>
	<20180126201326.8829-11-christian.koenig@amd.com>
	<6cf4bd37-fbf1-1fb4-496a-d62e403aea6f@amd.com>
	<7ebabb2b-1b18-8c7b-626f-d6874bdaac80@gmail.com>
	<c39b444b-49a1-771a-65ba-ae37ba643673@amd.com>
	<CAFCwf12ho2gXrBUHtaKRV-mX2kRk45xeu2o=F0-=Q+GFkAs=RA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <CAFCwf12ho2gXrBUHtaKRV-mX2kRk45xeu2o=F0-=Q+GFkAs=RA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
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
To: Oded Gabbay <oded.gabbay-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org>, jean-philippe.brucker-5wv7dgnIgG8@public.gmane.org
Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, amd-gfx list <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

Adding Jean and the IOMMU list as well.

Am 31.01.2018 um 13:43 schrieb Oded Gabbay:
> On Tue, Jan 30, 2018 at 6:53 PM, Felix Kuehling <felix.kuehling-5C7GfCeVMHo@public.gmane.org> wrote:
>> [SNIP]
> There was some discussion last year about a generic PASID allocator in
> the iommu subsystem:
> https://lists.linuxfoundation.org/pipermail/iommu/2017-June/022159.html
>
> Unfortunately, I don't think it got any further then that.

Yeah, that sounds exactly like what I had in mind as well.

Jean any updates on that topic? We are rather interested in common PASID 
handling as well.

Anybody already working on this? Sounds mostly like moving code around 
and creating a common interface.

Thanks,
Christian.
