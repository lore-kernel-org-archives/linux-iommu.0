From: Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>
Subject: Re: your mail
Date: Tue, 25 Feb 2014 15:01:25 +0000
Message-ID: <20140225150125.GC23136@mudshark.cambridge.arm.com>
References: <CAM0G4ztXWM5kw6dV4WRrTVJBMmeJDXuRnbeRBE603hM+7c=PCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAM0G4ztXWM5kw6dV4WRrTVJBMmeJDXuRnbeRBE603hM+7c=PCg-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/iommu/>
List-Post: <mailto:iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>
List-Help: <mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/iommu>,
	<mailto:iommu-request-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org?subject=subscribe>
Sender: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
Errors-To: iommu-bounces-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org
To: srikanth TS <srikantht.shivanand-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org" <iommu-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org>, "sungjinn.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <sungjinn.chung-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "ts.srikanth-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <ts.srikanth-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
List-Id: iommu@lists.linux-foundation.org

On Tue, Feb 25, 2014 at 11:20:11AM +0000, srikanth TS wrote:
> 
> On Feb 25, 2014 2:28 AM, "Will Deacon" <will.deacon-5wv7dgnIgG8@public.gmane.org<mailto:will.deacon-5wv7dgnIgG8@public.gmane.org>> wrote:
> >
> > On Mon, Feb 24, 2014 at 03:12:21PM +0000, srikanth TS wrote:
> > > Hi Will Deacon,
> >
> > Hello,
> >
> > > Currently SMMU driver expecting all stream ID used by respective master
> > > should be defined in the DT.
> > >
> > > We want to know how to handle in the case of virtual functions dynamically
> > > created and destroyed.
> > >
> > > Is PCI driver responsible for creating stream ID respective BDand
> > > requesting SMMU to add to the mapping table[stream Id to context mapping
> > > table]?
> > >
> > > Or is there any right way of doing it?
> >
> > Correct, the driver currently doesn't support dynamic mappings (mainly
> > because I didn't want to try and invent something that I couldn't test).
> >
> > There are a couple of ways to solve this:
> >
> >   (1) Add a way for a PCI RC to dynamically allocate StreamIDs on an SMMU
> >       within a fixed range. That would probably need some code in the bus
> >       layer, so that a bus notifier can kick and call back to the relevant
> >       SMMU.
> 
> I think first way of solving seems to be better, because we don't know how many
> 
> VF are used and i feel its not good idea to keep whole list of streamID [which is
> 
> equal to max num vf] in DT. Again in this method we need to generate the stream ID
> 
> dynamically whenever VF is added in pci iov driver side. And then pass that
> 
> stream ID to SMMU.
> 
> Is it ok this way?  Or you prefer 2nd way which is simpler.

I'm happy either way, but I'd need to see some patches before I can merge
anything ;)

Will
