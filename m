From: Varun Sethi <Varun.Sethi-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: RE: your mail
Date: Tue, 25 Feb 2014 11:28:49 +0000
Message-ID: <42a1041ac2df4a73a94dc4516969e35d@BL2PR03MB468.namprd03.prod.outlook.com>
References: <CAM0G4zvu1BHcOrSgBuobvb-+fVsNWXjXdzZdV51T70B9_ZC4XQ@mail.gmail.com>
	<20140224172850.GG2553@mudshark.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
In-Reply-To: <20140224172850.GG2553-MRww78TxoiP5vMa5CHWGZ34zcgK1vI+I0E9HWUfgJXw@public.gmane.org>
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
To: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, srikanth TS <srikantht.shivanand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "sungjinn.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <sungjinn.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ts.srikanth-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <ts.srikanth-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org



> -----Original Message-----
> From: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org [mailto:iommu-
> bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org] On Behalf Of Will Deacon
> Sent: Monday, February 24, 2014 10:59 PM
> To: srikanth TS
> Cc: iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org; sungjinn.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org; linux-
> kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org; ts.srikanth-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
> Subject: Re: your mail
> 
> On Mon, Feb 24, 2014 at 03:12:21PM +0000, srikanth TS wrote:
> > Hi Will Deacon,
> 
> Hello,
> 
> > Currently SMMU driver expecting all stream ID used by respective
> > master should be defined in the DT.
> >
> > We want to know how to handle in the case of virtual functions
> > dynamically created and destroyed.
> >
> > Is PCI driver responsible for creating stream ID respective BDand
> > requesting SMMU to add to the mapping table[stream Id to context
> > mapping table]?
> >
> > Or is there any right way of doing it?
> 
> Correct, the driver currently doesn't support dynamic mappings (mainly
> because I didn't want to try and invent something that I couldn't test).
> 
> There are a couple of ways to solve this:
> 
>   (1) Add a way for a PCI RC to dynamically allocate StreamIDs on an SMMU
>       within a fixed range. That would probably need some code in the bus
>       layer, so that a bus notifier can kick and call back to the
> relevant
>       SMMU.
This could be done in add device notifier. I am working on similar(not PCI) hot plug device infrastructure for arm smmu driver. I will post an RFC patch by next week.

-Varun
