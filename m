From: "Nath, Arindam" <Arindam.Nath-5C7GfCeVMHo@public.gmane.org>
Subject: RE: amd-iommu: can't boot with amdgpu, AMD-Vi: Completion-Wait loop
	timed out
Date: Tue, 21 Mar 2017 16:14:37 +0000
Message-ID: <MWHPR12MB15187F29F97E9920E3EF0AA69C3D0@MWHPR12MB1518.namprd12.prod.outlook.com>
References: <CAD8Lp457TE1CnJ-DHnB6NB2LWxgA5K5K57Q6L7XcSHeYNpvARQ@mail.gmail.com>
	<CY4PR12MB16533C83151D6FCFC11ED457F7250@CY4PR12MB1653.namprd12.prod.outlook.com>
	<CAD8Lp47zjJvqxY3TMMAhjz3OnLR52CtsQh_PQFPmsEW-xHfDwg@mail.gmail.com>
	<CADnq5_Oyfm-BzU9YV_QLjm6HxtMwnJcFkfYtjmCWpuah35TFvA@mail.gmail.com>
	<20170321155725.GD29659@8bytes.org>
	<BN6PR12MB16526DD4A3B60DB4E20B9907F73D0@BN6PR12MB1652.namprd12.prod.outlook.com>
	<20170321161056.GE29659@8bytes.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20170321161056.GE29659-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>
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
To: "'joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org'" <joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org>, "Deucher, Alexander" <Alexander.Deucher-5C7GfCeVMHo@public.gmane.org>
Cc: Chris Chiu <chiu-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, "amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org" <amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org>, Daniel Drake <drake-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>, "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, Alex Deucher <alexdeucher-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Linux Upstreaming Team <linux-6IF/jdPJHihWk0Htik3J/w@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

>-----Original Message-----
>From: 'joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org' [mailto:joro-zLv9SwRftAIdnm+yROfE0A@public.gmane.org]
>Sent: Tuesday, March 21, 2017 9:41 PM
>To: Deucher, Alexander
>Cc: Alex Deucher; Daniel Drake; Chris Chiu; amd-gfx-PD4FTy7X32lNgt0PjOBp9y5qC8QIuHrW@public.gmane.org;
>Nath, Arindam; iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; Suthikulpanit, Suravee;
>Linux Upstreaming Team
>Subject: Re: amd-iommu: can't boot with amdgpu, AMD-Vi: Completion-Wait
>loop timed out
>
>On Tue, Mar 21, 2017 at 04:01:53PM +0000, Deucher, Alexander wrote:
>> It seems to only affect Stoney systems, but not others (Carrizo,
>> Bristol, etc.).  Maybe we could just disable it on Stoney until we
>> root cause it.
>
>Completion-wait loop timeouts indicate something is seriously wrong. How
>can I detect whether I am running on a 'Stoney' system?
>
>Other question, a shot into the dark, does the GPU on these systems have
>ATS? Probably yes, as they are likely HSA compatible.

The GPU on Stoney supports ATS.

Thanks,
Arindam

>
>
>	Joerg
